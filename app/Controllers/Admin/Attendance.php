<?php

namespace App\Controllers\Admin;

use App\Models\JobAttendanceModel;
use CodeIgniter\Controller;

class Attendance extends BaseAdminController
{
    protected $attendance;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);

        $this->attendance = new JobAttendanceModel();
    }

    public function index()
    {
        return view('admin/attendance/index', [
            'title'     => 'Attendance'
        ]);
    }

    // =========================================
    // DATATABLE ATTENDANCE (SUMMARY HARIAN)
    // =========================================
    public function datatable()
    {
        $request = service('request');

        $search = $request->getPost('search')['value'] ?? null;
        $length = (int) $request->getPost('length');
        $start  = (int) $request->getPost('start');
        $draw   = (int) $request->getPost('draw');
        $order  = $request->getPost('order');

        $columns = [
            null,
            null,
            'job_attendances.created_at',
            'users.name',
            'hotels.hotel_name',
            'jobs.position',
            null,
            null
        ];

        $db = \Config\Database::connect();

        $baseBuilder = $db->table('job_attendances')
            ->select("
                DATE(job_attendances.created_at) AS work_date,
                IFNULL(users.name, '-') AS worker_name,
                IFNULL(hotels.hotel_name, '-') AS hotel_name,
                IFNULL(jobs.position, '-') AS position,
                jobs.start_time,
                jobs.end_time,
                jobs.fee,

                MIN(CASE WHEN job_attendances.type = 'checkin' THEN job_attendances.created_at END) AS checkin_time,
                MAX(CASE WHEN job_attendances.type = 'checkout' THEN job_attendances.created_at END) AS checkout_time,

                -- EXTEND AGGREGATE
                (
                    SELECT MIN(CASE WHEN type='checkin' THEN created_at END)
                    FROM job_extend_attendances jea
                    WHERE jea.user_id = job_attendances.user_id
                      AND jea.job_id = job_attendances.job_id
                      AND DATE(jea.created_at) = DATE(job_attendances.created_at)
                ) AS ex_checkin,

                (
                    SELECT MAX(CASE WHEN type='checkout' THEN created_at END)
                    FROM job_extend_attendances jea
                    WHERE jea.user_id = job_attendances.user_id
                      AND jea.job_id = job_attendances.job_id
                      AND DATE(jea.created_at) = DATE(job_attendances.created_at)
                ) AS ex_checkout,

                job_attendances.user_id,
                job_attendances.job_id
            ")
            ->join(
                'users',
                'users.id = job_attendances.user_id
                 AND users.deleted_at IS NULL
                 AND users.is_active = "active"',
                'left'
            )
            ->join('jobs', 'jobs.id = job_attendances.job_id', 'left')
            ->join('hotels', 'hotels.id = jobs.hotel_id', 'left')
            ->where('(job_attendances.deleted_at IS NULL OR job_attendances.deleted_at = "0000-00-00 00:00:00")', null, false)
            ->groupBy('job_attendances.user_id, job_attendances.job_id, DATE(job_attendances.created_at)');

        if ($search) {
            $baseBuilder->groupStart()
                ->like('users.name', $search)
                ->orLike('hotels.hotel_name', $search)
                ->orLike('jobs.position', $search)
            ->groupEnd();
        }

        $countBuilder = clone $baseBuilder;
        $recordsFiltered = count($countBuilder->get()->getResultArray());
        $recordsTotal    = $recordsFiltered;

        if ($order) {
            $idx = (int) $order[0]['column'];
            if (!empty($columns[$idx])) {
                $baseBuilder->orderBy($columns[$idx], $order[0]['dir']);
            }
        } else {
            $baseBuilder->orderBy('job_attendances.created_at', 'DESC');
        }

        if ($length > 0) {
            $baseBuilder->limit($length, $start);
        }

        $rows = $baseBuilder->get()->getResultArray();

        $data = [];
        $no = $start + 1;

        foreach ($rows as $row) {

            $checkin  = $row['checkin_time'];
            $checkout = $row['checkout_time'];

            $duration      = '-';
            $tenMinutesCnt = '-';
            $status        = 'Incomplete';
            $rate          = '-';
            $extendBadge   = '';

            if ($checkin && $checkout) {

                // ==========================
                // NORMAL WORK
                // ==========================
                $secondsNormal = strtotime($checkout) - strtotime($checkin);
                $minutesNormal = floor($secondsNormal / 60);

                // ==========================
                // EXTEND WORK
                // ==========================
                $extendMinutes = 0;

                if ($row['ex_checkin'] && $row['ex_checkout']) {

                    $extendSeconds = strtotime($row['ex_checkout']) - strtotime($row['ex_checkin']);
                    $extendMinutes = floor($extendSeconds / 60);

                    if ($extendMinutes > 0) {
                        $extendBadge = ' <span class="badge bg-label-info">EXT</span>';
                    }
                }

                // ==========================
                // TOTAL WORK
                // ==========================
                $totalMinutes = $minutesNormal + $extendMinutes;
                $totalSeconds = $totalMinutes * 60;

                $duration = gmdate('H:i', $totalSeconds);
                $status   = 'Complete';
                $tenMinutesCnt = floor($totalMinutes / 10);

                // ==========================
                // RATE CALCULATION
                // ==========================
                $jobStart = strtotime($row['start_time']);
                $jobEnd   = strtotime($row['end_time']);

                $jobMinutes = ($jobEnd - $jobStart) / 60;
                $jobTenMin  = floor($jobMinutes / 10);

                if ($jobTenMin > 0 && $row['fee'] > 0) {
                    $ratePer10Min = $row['fee'] / $jobTenMin;
                    $rate = round($tenMinutesCnt * $ratePer10Min);
                }
            }

            $data[] = [
                'no'                => $no++.'.',
                'date'              => date('d-m-Y', strtotime($row['work_date'])),
                'worker'            => esc($row['worker_name']),
                'job'               => esc($row['position']) . $extendBadge,
                'checkin'           => $checkin ? date('H:i', strtotime($checkin)) : '-',
                'checkout'          => $checkout ? date('H:i', strtotime($checkout)) : '-',
                'duration'          => $duration,
                'ten_minutes'       => $tenMinutesCnt,
                'rate'              => $rate !== '-' ? number_format($rate, 0, ',', '.') : '-',
                'status'            => $status,
                'extend_duration'   => $extendMinutes > 0 ? gmdate('H:i', $extendMinutes * 60) : '-',
                'action'            => '
                    <button 
                        class="btn btn-sm btn-info btn-detail"
                        data-user="'.$row['user_id'].'"
                        data-job="'.$row['job_id'].'"
                        data-date="'.$row['work_date'].'">
                        <i class="ti ti-eye"></i>
                    </button>
                '
            ];
        }

        return $this->response->setJSON([
            'draw'            => $draw,
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $data
        ]);
    }

    public function detail()
    {
        $req = $this->request;

        $userId = $req->getPost('user_id');
        $jobId  = $req->getPost('job_id');
        $date   = $req->getPost('date');

        $db = \Config\Database::connect();

        $rows = $db->table('job_attendances ja')
            ->select('
                ja.type,
                ja.created_at,
                ja.latitude,
                ja.longitude,
                ja.photo_path,
                u.name AS worker,
                h.hotel_name AS hotel,
                j.position AS job
            ')
            ->join('users u', 'u.id = ja.user_id', 'left')
            ->join('jobs j', 'j.id = ja.job_id', 'left')
            ->join('hotels h', 'h.id = j.hotel_id', 'left')
            ->where('ja.user_id', $userId)
            ->where('ja.job_id', $jobId)
            ->where('DATE(ja.created_at)', $date)
            ->where('(ja.deleted_at IS NULL OR ja.deleted_at = "0000-00-00 00:00:00")', null, false)
            ->orderBy('ja.created_at', 'ASC')
            ->get()
            ->getResultArray();

        $extend = $db->table('job_extend_requests')
            ->where('user_id', $userId)
            ->where('job_id', $jobId)
            ->where('DATE(original_end_time)', $date)
            ->orderBy('id', 'DESC')
            ->get()
            ->getRowArray();

        $extendAttendance = $db->table('job_extend_attendances')
            ->where('user_id', $userId)
            ->where('job_id', $jobId)
            ->where('DATE(created_at)', $date)
            ->orderBy('created_at', 'ASC')
            ->get()
            ->getResultArray();


        if (!$rows) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Data not found'
            ]);
        }

        $checkin  = null;
        $checkout = null;
        $lat = null;
        $lng = null;
        $photoIn  = null;
        $photoOut = null;

        foreach ($rows as $r) {
            if ($r['type'] === 'checkin') {
                $checkin  = $r['created_at'];
                $photoIn  = $r['photo_path'];
                $lat      = $r['latitude'];
                $lng      = $r['longitude'];
            }
            if ($r['type'] === 'checkout') {
                $checkout = $r['created_at'];
                $photoOut = $r['photo_path'];
            }
        }

        $duration = '-';
        $status   = 'Incomplete';

        if ($checkin && $checkout) {
            $seconds  = strtotime($checkout) - strtotime($checkin);
            $duration = gmdate('H:i', $seconds);
            $status   = 'Complete';
        }

        return $this->response->setJSON([
            'status' => true,
            'data'   => [
                'user_id'        => $userId,
                'job_id'         => $jobId,
                'date'           => date('Y-m-d', strtotime($rows[0]['created_at'])),
                'worker'         => $rows[0]['worker'],
                'hotel'          => $rows[0]['hotel'],
                'job'            => $rows[0]['job'],
                'checkin_time'   => $checkin ? date('H:i', strtotime($checkin)) : null,
                'checkout_time'  => $checkout ? date('H:i', strtotime($checkout)) : null,
                'duration'       => $duration,
                'status'         => $status,
                'latitude'       => $lat,
                'longitude'      => $lng,
                'checkin_photo'  => $photoIn,
                'checkout_photo' => $photoOut,
                'extend'         => $extend,
                'extend_attendance' => $extendAttendance
            ]
        ]);
    }

    public function submitRating()
    {
        // hanya hotel_hr & admin
        if (!in_array(session('user_role'), ['hotel_hr', 'admin'])) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Unauthorized'
            ]);
        }

        $req = $this->request;

        $data = [
            'user_id'     => $req->getPost('user_id'),
            'job_id'      => $req->getPost('job_id'),
            'date'        => $req->getPost('date'),
            'punctuality' => (int) $req->getPost('punctuality'),
            'apperance'   => (int) $req->getPost('apperance'),
            'knowledge'   => (int) $req->getPost('knowledge'),
            'durability'  => (int) $req->getPost('durability'),
            'ethics'      => (int) $req->getPost('ethics'),
            'comments'    => $req->getPost('comments'),
            'created_at'  => date('Y-m-d H:i:s'),
            'created_by'  => session('user_id')
        ];

        // validasi minimal
        foreach (['punctuality','apperance','knowledge','durability','ethics'] as $f) {
            if ($data[$f] < 1 || $data[$f] > 5) {
                return $this->response->setJSON([
                    'status' => false,
                    'message' => 'All ratings must be filled'
                ]);
            }
        }

        $db = \Config\Database::connect();

        // ❗ cegah rating dobel (user + job + date)
        $exists = $db->table('worker_ratings')
            ->where('user_id', $data['user_id'])
            ->where('job_id', $data['job_id'])
            ->where('date', $data['date'])
            ->where('deleted_at', null)
            ->countAllResults();

        if ($exists > 0) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'This worker has already been rated'
            ]);
        }

        $db->table('worker_ratings')->insert($data);

        return $this->response->setJSON([
            'status' => true,
            'message' => 'Rating submitted successfully'
        ]);
    }

    public function extendRequest()
    {
        // hanya HR / admin
        if (!in_array(session('user_role'), ['hotel_hr', 'admin'])) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Unauthorized'
            ]);
        }

        $req = $this->request;
        $db  = \Config\Database::connect();

        $userId = $req->getPost('user_id');
        $jobId  = $req->getPost('job_id');
        $date   = $req->getPost('date');
        $requestedTime = $req->getPost('requested_time');
        $reason = $req->getPost('reason');

        if (!$requestedTime) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Extend time is required'
            ]);
        }

        $application = $db->table('job_applications')
            ->select('id')
            ->where('job_id', $jobId)
            ->where('user_id', $userId)
            ->where('deleted_at', null)
            ->get()
            ->getRowArray();

        if (!$application) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Application not found'
            ]);
        }

        $applicationId = $application['id'];

        // Ambil checkout terakhir hari itu
        $attendance = $db->table('job_attendances')
            ->select('MAX(created_at) as checkout_time')
            ->where('user_id', $userId)
            ->where('job_id', $jobId)
            ->where('DATE(created_at)', $date)
            ->where('type', 'checkout')
            ->get()
            ->getRowArray();

        if (!$attendance || !$attendance['checkout_time']) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Worker has not checked out yet'
            ]);
        }

        $originalCheckout = $attendance['checkout_time'];

        $requestedDateTime = date('Y-m-d H:i:s', strtotime($date . ' ' . $requestedTime));
        $originalDateTime  = date('Y-m-d H:i:s', strtotime($originalCheckout));

        if (strtotime($requestedDateTime) <= strtotime($originalDateTime)) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Extend time must be greater than checkout time'
            ]);
        }

        $minutes = floor((strtotime($requestedDateTime) - strtotime($originalDateTime)) / 60);

        // Cegah double pending
        $pending = $db->table('job_extend_requests')
            ->where('user_id', $userId)
            ->where('job_id', $jobId)
            ->where('DATE(original_end_time)', $date)
            ->where('status', 'pending')
            ->countAllResults();

        if ($pending > 0) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'There is already a pending extend request'
            ]);
        }

        // =============================
        // HITUNG ESTIMATED FEE
        // =============================

        $job = $db->table('jobs')
            ->select('start_time, end_time, fee')
            ->where('id', $jobId)
            ->get()
            ->getRowArray();

        $jobStart = strtotime($job['start_time']);
        $jobEnd   = strtotime($job['end_time']);

        $jobMinutes = ($jobEnd - $jobStart) / 60;
        $jobTenMin  = floor($jobMinutes / 10);

        $ratePer10Min = $jobTenMin > 0 ? $job['fee'] / $jobTenMin : 0;

        $extendTenMin = floor($minutes / 10);

        $estimatedFee = round($extendTenMin * $ratePer10Min);

        $db->table('job_extend_requests')->insert([
            'job_id'            => $jobId,
            'user_id'           => $userId,
            'application_id'    => $applicationId,
            'requested_by'      => session('user_id'),
            'original_end_time' => $originalDateTime,
            'requested_end_time'=> $requestedDateTime,
            'requested_minutes' => $minutes,
            'estimated_fee'     => $estimatedFee,
            'final_fee'         => $estimatedFee,
            'status'            => 'pending',
            'reason'            => $reason,
            'created_at'        => date('Y-m-d H:i:s')
        ]);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Extend request sent to worker'
        ]);
    }

}
