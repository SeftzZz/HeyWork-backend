<?php

namespace App\Controllers\Admin;

use App\Controllers\BaseController;
use Config\Database;

class Schedules extends BaseController
{
    protected $db;

    public function __construct()
    {
        $this->db = Database::connect();
    }

    public function index()
    {
        $hotelId = session()->get('hotel_id');
        $role    = session()->get('user_role');

        $builder = $this->db->table('users u')
            ->distinct()
            ->select('u.id, u.name, u.role')
            ->where('u.hotel_id', $hotelId)
            ->where('u.is_active', 'active');

        if (!in_array($role, ['admin','hotel_hr','hotel_gm'])) {

            $department = $this->getDepartmentFromRole($role);

            $builder->join('job_attendances ja', 'ja.user_id = u.id', 'left')
                    ->join('jobs j', 'j.id = ja.job_id', 'left')
                    ->join('skills s', 's.name = j.position', 'left')
                    ->groupStart()
                        ->where('s.category', $department) // worker dept
                        ->orWhere('u.role', $role)         // manager sendiri
                    ->groupEnd();
        }

        $workers = $builder
            ->groupBy('u.id')
            ->orderBy('u.name', 'ASC')
            ->get()
            ->getResultArray();

        return view('admin/schedules/index', [
            'title'   => 'Schedules',
            'workers' => $workers
        ]);
    }

    public function datatable()
    {
        $request = service('request');

        $searchValue = $request->getPost('search')['value'] ?? null;
        $length      = (int) $request->getPost('length');
        $start       = (int) $request->getPost('start');
        $order       = $request->getPost('order');

        $hotelId  = session()->get('hotel_id');
        $userRole = session()->get('user_role');

        $orderColumns = [
            null,
            null,
            'schedule_plans.department',
            'schedule_plans.month',
            'schedule_plans.year',
            'schedule_plans.status',
            'users.name',
            'schedule_plans.created_at'
        ];

        // =============================
        // TOTAL RECORDS
        // =============================
        $totalQuery = $this->db->table('schedule_plans')
            ->where('hotel_id', $hotelId);

        if (!in_array($userRole, ['admin','hotel_hr','hotel_gm'])) {
            $department = $this->getDepartmentFromRole($userRole);
            if ($department) {
                $totalQuery->where('department', $department);
            }
        }

        $recordsTotal = $totalQuery->countAllResults();


        // =============================
        // BASE DATA QUERY
        // =============================
        $dataQuery = $this->db->table('schedule_plans')
            ->select('schedule_plans.*, users.name as requester_name')
            ->join('users', 'users.id = schedule_plans.requested_by', 'left')
            ->where('schedule_plans.hotel_id', $hotelId);

        if (!in_array($userRole, ['admin','hotel_hr','hotel_gm'])) {
            $department = $this->getDepartmentFromRole($userRole);
            if ($department) {
                $dataQuery->where('schedule_plans.department', $department);
            }
        }

        // =============================
        // SEARCH
        // =============================
        if (!empty($searchValue)) {
            $dataQuery->groupStart()
                ->like('schedule_plans.department', $searchValue)
                ->orLike('schedule_plans.month', $searchValue)
                ->orLike('schedule_plans.year', $searchValue)
                ->orLike('schedule_plans.status', $searchValue)
                ->orLike('users.name', $searchValue)
                ->groupEnd();
        }

        // =============================
        // COUNT FILTERED
        // =============================
        $filteredQuery = clone $dataQuery;
        $recordsFiltered = $filteredQuery->countAllResults();

        // =============================
        // ORDERING
        // =============================
        if (!empty($order)) {
            $idx = (int) $order[0]['column'];
            if (!empty($orderColumns[$idx])) {
                $dataQuery->orderBy($orderColumns[$idx], $order[0]['dir']);
            }
        } else {
            $dataQuery->orderBy('schedule_plans.year', 'DESC')
                      ->orderBy('schedule_plans.month', 'DESC');
        }

        // =============================
        // LIMIT + FETCH
        // =============================
        $data = $dataQuery
            ->limit($length, $start)
            ->get()
            ->getResultArray();

        // =============================
        // FORMAT OUTPUT
        // =============================
        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {
            $badge = match ($row['status']) {
                'pending'  => '<span class="badge bg-label-warning">Pending</span>',
                'approved' => '<span class="badge bg-label-success">Approved</span>',
                'rejected' => '<span class="badge bg-label-danger">Rejected</span>',
                'draft'    => '<span class="badge bg-label-secondary">Draft</span>',
                default    => '<span class="badge bg-label-info">'.ucfirst($row['status']).'</span>',
            };

            $actionBtn = '
                <div class="d-flex gap-2">
                    <a href="javascript:void(0)"
                       class="btn btn-sm btn-icon btn-primary btn-view"
                       data-id="'.$row['id'].'"
                       title="View">
                        <i class="ti ti-eye"></i>
                    </a>
            ';

            if ($row['status'] === 'approved') {
                $actionBtn .= '
                    <button class="btn btn-sm btn-icon btn-warning btn-revision"
                            data-id="'.$row['id'].'"
                            title="Request Revision">
                        <i class="ti ti-edit"></i>
                    </button>
                ';
            }

            $actionBtn .= '</div>';

            $result[] = [
                'no'         => $no++,
                'department' => esc($row['department']),
                'month'      => esc(date('F', mktime(0,0,0,$row['month'],1))),
                'year'       => esc($row['year']),
                'status'     => $badge,
                'requester'  => esc($row['requester_name'] ?? '-'),
                'created_at' => date('d M Y H:i', strtotime($row['created_at'])),
                'action'     => $actionBtn
            ];
        }

        return $this->response->setJSON([
            'draw'            => (int) $request->getPost('draw'),
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $result
        ]);
    }

    public function store()
    {
        $hotelId = session()->get('hotel_id');
        $userId  = session()->get('user_id');
        $role    = session()->get('user_role');

        $month = (int) $this->request->getPost('month');
        $year  = (int) $this->request->getPost('year');

        $department = in_array($role, ['admin','hotel_hr','hotel_fo','hotel_hk','hotel_fnb_service','hotel_fnb_production','hotel_fna','hotel_eng','hotel_sales','hotel_gm'])
            ? trim($this->request->getPost('department'))
            : $this->getDepartmentFromRole($role);

        // ===============================
        // VALIDATION
        // ===============================
        if (!$department) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Department required'
            ]);
        }

        if ($month < 1 || $month > 12 || $year < 2000) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Invalid month or year'
            ]);
        }

        // ===============================
        // PREVENT DUPLICATE
        // ===============================
        $exists = $this->db->table('schedule_plans')
            ->where([
                'hotel_id'   => $hotelId,
                'department' => $department,
                'month'      => $month,
                'year'       => $year
            ])
            ->countAllResults();

        if ($exists > 0) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Schedule already exists for this month'
            ]);
        }

        // ===============================
        // TRANSACTION
        // ===============================
        $this->db->transBegin();

        $planData = [
            'hotel_id'     => $hotelId,
            'department'   => $department,
            'month'        => $month,
            'year'         => $year,
            'status'       => 'pending',
            'requested_by' => $userId,
            'created_at'   => date('Y-m-d H:i:s')
        ];

        $this->db->table('schedule_plans')->insert($planData);

        $planId = $this->db->insertID();

        if (!$planId) {
            $this->db->transRollback();
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Failed to create schedule plan'
            ]);
        }

        // ===============================
        // AUTO GENERATE schedule_days
        // ===============================
        $daysInMonth = (int) date('t', strtotime($year . '-' . $month . '-01'));

        $dayBatch = [];

        for ($d = 1; $d <= $daysInMonth; $d++) {

            $date = $year . '-' .
                    str_pad($month, 2, '0', STR_PAD_LEFT) . '-' .
                    str_pad($d, 2, '0', STR_PAD_LEFT);

            $dayBatch[] = [
                'schedule_plan_id' => $planId,
                'shift_date'       => $date,
                'created_at'       => date('Y-m-d H:i:s')
            ];
        }

        $this->db->table('schedule_days')->insertBatch($dayBatch);

        // ===============================
        // FINALIZE TRANSACTION
        // ===============================
        if ($this->db->transStatus() === false) {
            $this->db->transRollback();
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Failed to create schedule'
            ]);
        }

        $this->db->transCommit();

        return $this->response->setJSON([
            'status' => true,
            'message' => 'Schedule plan created and calendar days generated.'
        ]);
    }

    public function getDetail()
    {
        $id = $this->request->getPost('id');
        // ===============================
        // GET PLAN
        // ===============================
        $plan = $this->db->table('schedule_plans')
            ->where('id', $id)
            ->get()
            ->getRowArray();

        if (!$plan) {
            return $this->response->setJSON([
                'status' => false
            ]);
        }
        // ===============================
        // GET DAYS + SHIFTS
        // ===============================
        $rows = $this->db->table('schedule_days d')
            ->select('
                d.shift_date,
                s.user_id,
                s.start_time,
                s.end_time,
                s.shift_type,
                u.name as worker_name
            ')
            ->join('schedule_shifts s', 's.schedule_day_id = d.id', 'left')
            ->join('users u', 'u.id = s.user_id', 'left')
            ->where('d.schedule_plan_id', $id)
            ->orderBy('d.shift_date', 'ASC')
            ->get()
            ->getResultArray();

        // ===============================
        // FORMAT BY DATE (GROUPING)
        // ===============================
        $grouped = [];
        foreach ($rows as $row) {
            $date = $row['shift_date'];
            if (!isset($grouped[$date])) {
                $grouped[$date] = [
                    'shift_date' => $date,
                    'shifts' => []
                ];
            }

            if ($row['user_id']) {
                $grouped[$date]['shifts'][] = [
                    'user_id'     => $row['user_id'],
                    'worker_name' => $row['worker_name'],
                    'start_time'  => $row['start_time'],
                    'end_time'    => $row['end_time'],
                    'shift_type'  => $row['shift_type']
                ];
            }
        }

        $details = array_values($grouped);
        // ===============================
        // STATUS BADGE
        // ===============================
        $badge = match ($plan['status']) {
            'pending'  => '<span class="badge bg-label-warning">Pending</span>',
            'approved' => '<span class="badge bg-label-success">Approved</span>',
            'rejected' => '<span class="badge bg-label-danger">Rejected</span>',
            'revised'  => '<span class="badge bg-label-info">Revised</span>',
            default    => '<span class="badge bg-label-secondary">'.ucfirst($plan['status']).'</span>',
        };

        return $this->response->setJSON([
            'status' => true,
            'data' => [
                'department'   => $plan['department'],
                'month_name'   => date('F', mktime(0,0,0,$plan['month'],1)),
                'year'         => $plan['year'],
                'status_badge' => $badge,
                'status_raw'   => $plan['status']
            ],
            'details' => $details
        ]);
    }

    public function assignShift()
    {
        $planId = $this->request->getPost('schedule_plan_id');
        $date   = $this->request->getPost('shift_date');
        $userId = $this->request->getPost('user_id');
        $start  = $this->request->getPost('start_time');
        $end    = $this->request->getPost('end_time');
        $type   = $this->request->getPost('shift_type') ?? 'regular';

        $jobId         = $this->request->getPost('job_id');
        $applicationId = $this->request->getPost('application_id');

        if (!$planId || !$date || !$userId || !$start || !$end) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Incomplete data'
            ]);
        }

        // =========================
        // BUILD DATETIME RANGE
        // =========================
        $startDateTime = strtotime($date . ' ' . $start);
        $endDateTime   = strtotime($date . ' ' . $end);

        // SHIFT LINTAS HARI
        if ($endDateTime <= $startDateTime) {
            $endDateTime = strtotime('+1 day', $endDateTime);
        }

        $durationHours = ($endDateTime - $startDateTime) / 3600;

        if ($durationHours > 16) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Shift duration too long'
            ]);
        }

        // =========================
        // CHECK PLAN STATUS
        // =========================
        $plan = $this->db->table('schedule_plans')
            ->where('id', $planId)
            ->get()
            ->getRowArray();

        if (!$plan) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Schedule plan not found'
            ]);
        }

        // if ($plan['status'] === 'approved') {
        //     return $this->response->setJSON([
        //         'status' => false,
        //         'message' => 'Cannot modify approved schedule'
        //     ]);
        // }

        // =========================
        // FIND SCHEDULE DAY
        // =========================
        $day = $this->db->table('schedule_days')
            ->where([
                'schedule_plan_id' => $planId,
                'shift_date'       => $date
            ])
            ->get()
            ->getRowArray();

        if (!$day) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Schedule day not found'
            ]);
        }

        $scheduleDayId = $day['id'];

        // =========================
        // OVERLAP CHECK (CROSS DAY SAFE)
        // =========================
        $shifts = $this->db->table('schedule_shifts')
            ->where('user_id', $userId)
            ->get()
            ->getResultArray();

        foreach ($shifts as $shift) {

            $shiftDay = $this->db->table('schedule_days')
                ->where('id', $shift['schedule_day_id'])
                ->get()
                ->getRowArray();

            $shiftStart = strtotime($shiftDay['shift_date'] . ' ' . $shift['start_time']);
            $shiftEnd   = strtotime($shiftDay['shift_date'] . ' ' . $shift['end_time']);

            if ($shiftEnd <= $shiftStart) {
                $shiftEnd = strtotime('+1 day', $shiftEnd);
            }

            // OVERLAP DETECTION
            if ($startDateTime < $shiftEnd && $endDateTime > $shiftStart) {
                return $this->response->setJSON([
                    'status' => false,
                    'message' => 'Shift time overlaps with existing shift'
                ]);
            }
        }

        // =========================
        // OPTIONAL JOB VALIDATION
        // =========================
        if ($jobId && $applicationId) {

            $validJob = $this->db->table('job_applications ja')
                ->join('jobs j', 'j.id = ja.job_id')
                ->where('ja.id', $applicationId)
                ->where('ja.user_id', $userId)
                ->where('j.id', $jobId)
                ->where('j.job_date_start <=', $date)
                ->where('j.job_date_end >=', $date)
                ->get()
                ->getRowArray();

            if (!$validJob) {
                return $this->response->setJSON([
                    'status' => false,
                    'message' => 'Invalid job or application for this date'
                ]);
            }

        } else {
            $jobId = null;
            $applicationId = null;
        }

        // =========================
        // INSERT SHIFT
        // =========================
        $this->db->table('schedule_shifts')->insert([
            'schedule_day_id' => $scheduleDayId,
            'user_id'         => $userId,
            'job_id'          => $jobId,
            'application_id'  => $applicationId,
            'start_time'      => $start,
            'end_time'        => $end,
            'shift_type'      => $type,
            'created_at'      => date('Y-m-d H:i:s')
        ]);

        return $this->response->setJSON([
            'status' => true,
            'message' => 'Shift assigned successfully'
        ]);
    }

    public function requestRevision()
    {
        $userId = session()->get('user_id');
        $id = $this->request->getPost('id');

        $revisionData = [
            'schedule_plan_id' => $id,
            'revision_number'  => $this->getNextRevisionNumber($id),
            'requested_by'     => $userId,
            'status'           => 'pending'
        ];

        $this->db->table('schedule_revisions')->insert($revisionData);

        return redirect()->back()->with('success','Revision submitted for approval');
    }

    private function getDepartmentFromRole($role)
    {
        $map = [
            'hotel_fo'             => 'Front Office',
            'hotel_hk'             => 'Housekeeping',
            'hotel_fnb_service'    => 'Food & Beverage Service',
            'hotel_fnb_production' => 'Kitchen / Culinary',
            'hotel_fna'            => 'Finance',
            'hotel_eng'            => 'Engineering',
            'hotel_sales'          => 'Sales & Marketing',
            'hotel_gm'             => 'Management'
        ];

        return $map[$role] ?? null;
    }

    private function getNextRevisionNumber($id)
    {
        $row = $this->db->table('schedule_revisions')
            ->selectMax('revision_number')
            ->where('schedule_plan_id', $id)
            ->get()
            ->getRow();

        return $row->revision_number + 1 ?? 1;
    }
}