<?php

namespace App\Controllers\Admin;

use App\Models\TransactionModel;

class Payments extends BaseAdminController
{
    protected $transactionModel;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);
        $this->transactionModel = new TransactionModel();
    }

    public function index()
    {
        return view('admin/payments/index', [
            'title'     => 'Payments',
        ]);
    }

    // ===================================================
    // DATATABLE (DEBIT ONLY = INVOICE)
    // ===================================================
    public function datatable()
    {
        $request = service('request');
        $search  = $request->getPost('search')['value'] ?? null;
        $length  = (int) $request->getPost('length');
        $start   = (int) $request->getPost('start');
        $draw    = (int) $request->getPost('draw');

        $db = \Config\Database::connect();

        // =========================
        // BASE QUERY
        // =========================
        $builder = $db->table('job_attendances')
            ->select("
                job_attendances.application_id,
                job_attendances.type,
                job_attendances.created_at,
                users.name AS worker_name,
                jobs.position,
                schedule_shifts.start_time,
                schedule_shifts.end_time,
                schedule_days.shift_date,
                jobs.fee,
                jobs.hotel_id,
                hotels.hotel_name,
                YEARWEEK(job_attendances.created_at,1) AS week_key
            ")
            ->join('job_applications', 'job_applications.id = job_attendances.application_id', 'left')
            ->join('users', 'users.id = job_applications.user_id', 'left')
            ->join('jobs', 'jobs.id = job_applications.job_id', 'left')
            ->join('hotels', 'hotels.id = jobs.hotel_id', 'left')
            ->join(
                'schedule_shifts',
                'schedule_shifts.application_id = job_attendances.application_id
                 AND schedule_shifts.user_id = job_applications.user_id',
                'left'
            )
            ->join(
                'schedule_days',
                'schedule_days.id = schedule_shifts.schedule_day_id',
                'left'
            )
            ->whereIn('jobs.category', ['daily_worker','casual'])
            ->where('job_applications.status', 'completed')
            ->where('job_attendances.billed', 0)
            ->orderBy('job_attendances.application_id', 'ASC')
            ->orderBy('job_attendances.created_at', 'ASC');

        // =========================
        // SEARCH
        // =========================
        if ($search) {
            $builder->groupStart()
                ->like('users.name', $search)
                ->orLike('hotels.hotel_name', $search)
            ->groupEnd();
        }

        $rows = $builder->get()->getResultArray();

        // =========================
        // GROUPING
        // =========================
        $grouped = [];

        foreach ($rows as $row) {

            if (!$row['week_key']) continue;

            $appId = (int)$row['application_id'];
            $week  = $row['week_key'];
            $hotel = $row['hotel_name'] ?? 'Unknown';
            $key = $week . '_' . $row['hotel_id'];

            // init group
            if (!isset($grouped[$key])) {
                $grouped[$key] = [
                    'week_key'      => $week,
                    'hotel_id'      => $row['hotel_id'],
                    'hotel_name'    => $hotel,
                    'total_amount'  => 0,
                    'total_minutes' => 0,
                    'working_days'  => 0,
                    'workers'       => []
                ];
            }

            // init worker
            if (!isset($grouped[$key]['workers'][$appId])) {
                $grouped[$key]['workers'][$appId] = [
                    'worker_name' => $row['worker_name'],
                    'position'    => $row['position'],
                    'fee'         => (float)$row['fee'],
                    'start_time'  => $row['start_time'],
                    'end_time'    => $row['end_time'],
                    'checkins'    => [],
                    'checkouts'   => []
                ];
            }

            // normalize by date (ANTI DUPLICATE)
            $date = date('Y-m-d', strtotime($row['created_at']));

            if ($row['type'] === 'checkin') {
                $grouped[$key]['workers'][$appId]['checkins'][$date] = $row['created_at'];
            }

            if ($row['type'] === 'checkout') {
                $grouped[$key]['workers'][$appId]['checkouts'][$date] = $row['created_at'];
            }
        }

        // =========================
        // CALCULATION
        // =========================
        foreach ($grouped as &$g) {
            foreach ($g['workers'] as $worker) {
                // skip invalid shift
                if (!$worker['start_time'] || !$worker['end_time']) continue;
                $jobStart = strtotime($worker['start_time']);
                $jobEnd   = strtotime($worker['end_time']);
                if (!$jobStart || !$jobEnd) continue;
                // potong 1 jam untuk istirahat
                $jobMinutes = (($jobEnd - $jobStart) / 60) - 60;
                if ($jobMinutes <= 0) continue;
                $jobTenMin  = floor($jobMinutes / 10);
                if ($jobTenMin <= 0 || $worker['fee'] <= 0) continue;
                $ratePer10Min = $worker['fee'] / $jobTenMin;
                foreach ($worker['checkins'] as $date => $checkin) {
                    if (!isset($worker['checkouts'][$date])) continue;
                    $checkout = $worker['checkouts'][$date];
                    $seconds = max(
                        0,
                        (strtotime($checkout) - strtotime($checkin)) - 3600 // break 1 jam
                    );

                    $minutes = floor($seconds / 60);
                    if ($minutes <= 0) continue;

                    $g['working_days']++;
                    $g['total_minutes'] += $minutes;

                    $g['total_amount'] += round(
                        floor($minutes / 10) * $ratePer10Min
                    );
                }
            }
        }
        unset($g);

        // =========================
        // PAGINATION
        // =========================
        $recordsTotal = count($grouped);

        $grouped = array_values($grouped);

        $paged = ($length != -1)
            ? array_slice($grouped, $start, $length)
            : $grouped;

        // =========================
        // FORMAT OUTPUT
        // =========================
        $data = [];
        $no   = $start + 1;

        foreach ($paged as $g) {
            $year = substr($g['week_key'], 0, 4);
            $week = substr($g['week_key'], 4);

            $hours   = floor($g['total_minutes'] / 60);
            $minutes = $g['total_minutes'] % 60;

            $workerCount = count($g['workers']);

            // safe truncate hotel name
            $name  = $g['hotel_name'];
            $short = mb_strlen($name) > 13 ? mb_substr($name, 0, 13) . '...' : $name;

            $data[] = [
                'no' => $no++ . '.',
                'hotel' => '<span 
                                data-bs-toggle="tooltip"
                                data-bs-placement="bottom"
                                title="' . esc($name) . '"
                            >' . esc($short) . '</span>',
                'worker' => $workerCount,
                'job' => 'Week ' . $week . ' / ' . $year,
                'working_days' => $g['working_days'] . ' Days',
                'duration' => $hours . 'h ' . $minutes . 'm',
                'amount' => 'Rp ' . number_format($g['total_amount'], 0, ',', '.'),
                'action' => '
                    <a href="' . base_url('/admin/invoices/create-week/' . $g['week_key'] . '/' . $g['hotel_id']) . '" 
                       class="btn btn-sm btn-primary">
                       Create Invoice
                    </a>'
            ];
        }

        return $this->response->setJSON([
            'draw'            => $draw,
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsTotal,
            'data'            => $data
        ]);
    }
}