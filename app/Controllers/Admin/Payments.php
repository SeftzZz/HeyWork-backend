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
                jobs.start_time,
                jobs.end_time,
                jobs.fee,

                (
                    SELECT invoices.status
                    FROM invoice_items
                    JOIN invoices ON invoices.id = invoice_items.invoice_id
                    WHERE invoice_items.application_id = job_attendances.application_id
                    ORDER BY invoices.id DESC
                    LIMIT 1
                ) AS payment_status
            ")
            ->join('job_applications', 'job_applications.id = job_attendances.application_id', 'left')
            ->join('users', 'users.id = job_applications.user_id', 'left')
            ->join('jobs', 'jobs.id = job_applications.job_id', 'left')
            ->where('jobs.hotel_id', session()->get('hotel_id'))
            ->whereIn('jobs.category', ['daily_worker', 'casual'])
            ->where('job_applications.status', 'completed')
            ->orderBy('job_attendances.application_id', 'ASC')
            ->orderBy('job_attendances.created_at', 'ASC')
            ->distinct();

        if ($search) {
            $builder->groupStart()
                ->like('users.name', $search)
                ->orLike('jobs.position', $search)
            ->groupEnd();
        }

        $rows = $builder->get()->getResultArray();

        // =========================
        // GROUP PER WORKER
        // =========================
        $grouped = [];

        foreach ($rows as $row) {

            $appId = (int) $row['application_id'];

            if (!isset($grouped[$appId])) {
                $grouped[$appId] = [
                    'worker_name'    => $row['worker_name'],
                    'position'       => $row['position'],
                    'start_time'     => $row['start_time'],
                    'end_time'       => $row['end_time'],
                    'fee'            => $row['fee'],
                    'payment_status' => $row['payment_status'],
                    'total_amount'   => 0,
                    'total_minutes'  => 0,
                    'working_days'   => 0,
                    'checkins'       => [],
                    'checkouts'      => []
                ];
            }

            if ($row['type'] === 'checkin') {
                $grouped[$appId]['checkins'][] = $row['created_at'];
            }

            if ($row['type'] === 'checkout') {
                $grouped[$appId]['checkouts'][] = $row['created_at'];
            }
        }

        // =========================
        // HITUNG TOTAL
        // =========================
        foreach ($grouped as $appId => &$g) {

            $count = min(count($g['checkins']), count($g['checkouts']));

            for ($i = 0; $i < $count; $i++) {

                $seconds = strtotime($g['checkouts'][$i]) - strtotime($g['checkins'][$i]);
                $minutes = floor($seconds / 60);

                if ($minutes <= 0) {
                    continue;
                }

                // Tambah hari kerja
                $g['working_days']++;

                // Tambah total menit
                $g['total_minutes'] += $minutes;

                // Hitung billing per 10 menit
                $jobStart = strtotime($g['start_time']);
                $jobEnd   = strtotime($g['end_time']);

                $jobMinutes = ($jobEnd - $jobStart) / 60;
                $jobTenMin  = floor($jobMinutes / 10);

                if ($jobTenMin > 0 && $g['fee'] > 0) {
                    $ratePer10Min = $g['fee'] / $jobTenMin;
                    $g['total_amount'] += round(floor($minutes / 10) * $ratePer10Min);
                }
            }
        }
        unset($g);

        // =========================
        // PAGINATION MANUAL
        // =========================
        $recordsTotal = count($grouped);

        $grouped = array_values($grouped);
        $paged   = ($length != -1)
            ? array_slice($grouped, $start, $length)
            : $grouped;

        // =========================
        // FORMAT OUTPUT
        // =========================
        $data = [];
        $no   = $start + 1;

        foreach ($paged as $g) {

            $hours   = floor($g['total_minutes'] / 60);
            $minutes = $g['total_minutes'] % 60;

            $paymentStatus = strtolower($g['payment_status'] ?? 'unbilled');

            $badgeClass = match ($paymentStatus) {
                'paid'      => 'bg-success',
                'partial'   => 'bg-warning',
                'sent'      => 'bg-info',
                'draft'     => 'bg-secondary',
                'overdue'   => 'bg-danger',
                default     => 'bg-warning'
            };

            $data[] = [
                'no'            => $no++.'.',
                'worker'        => esc($g['worker_name']),
                'job'           => esc($g['position']),
                'working_days'  => $g['working_days'] . ' Days',
                'duration'      => $hours . 'h ' . $minutes . 'm',
                'application_id'=> $appId,
                'amount'        => 'Rp ' . number_format($g['total_amount'], 0, ',', '.'),
                'status'        => '<span class="badge '.$badgeClass.'">'
                                    . strtoupper($paymentStatus) .
                                   '</span>',
                'action'        => '
                                    <a href="'.base_url('admin/invoices/create/'.$appId).'"
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