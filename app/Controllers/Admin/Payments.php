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

        // Subquery overtime
        $overtimeSub = "
            SELECT
                application_id,
                TIMESTAMPDIFF(
                    MINUTE,
                    MIN(CASE WHEN type='checkin' THEN created_at END),
                    MAX(CASE WHEN type='checkout' THEN created_at END)
                ) AS overtime_minutes
            FROM job_extend_attendances
            GROUP BY application_id
        ";

        $builder = $db->table('schedule_shifts ss')
            ->select("
                YEARWEEK(sd.shift_date,1) AS week_key,
                j.hotel_id,
                h.hotel_name,

                COUNT(DISTINCT ss.application_id) AS workers,
                COUNT(DISTINCT sd.shift_date) AS working_days,

                SUM(
                    GREATEST(
                        TIMESTAMPDIFF(
                            MINUTE,
                            CONCAT(sd.shift_date,' ',ss.start_time),
                            CONCAT(sd.shift_date,' ',ss.end_time)
                        ) - 60,
                        0
                    )
                ) 
                +
                SUM(IFNULL(ot.overtime_minutes,0))
                AS total_minutes,

                SUM(
                    j.fee
                    +
                    (
                        IFNULL(ot.overtime_minutes,0)
                        *
                        (
                            j.fee /
                            GREATEST(
                                TIMESTAMPDIFF(
                                    MINUTE,
                                    CONCAT(sd.shift_date,' ',ss.start_time),
                                    CONCAT(sd.shift_date,' ',ss.end_time)
                                ) - 60,
                                1
                            )
                        )
                    )
                ) AS total_amount
            ")

            ->join('schedule_days sd','sd.id = ss.schedule_day_id','left')
            ->join('job_applications ja','ja.id = ss.application_id','left')
            ->join('jobs j','j.id = ja.job_id','left')
            ->join('hotels h','h.id = j.hotel_id','left')
            ->join("($overtimeSub) ot",'ot.application_id = ss.application_id','left')

            ->whereIn('ss.shift_type',['regular','overtime'])
            ->whereIn('j.category',['daily_worker','casual'])

            ->groupBy('week_key, j.hotel_id')
            ->orderBy('week_key','DESC');

        // Search
        if ($search) {
            $builder->groupStart()
                ->like('h.hotel_name',$search)
            ->groupEnd();
        }

        // Total records
        $recordsTotal = $builder->countAllResults(false);

        // Pagination SQL (lebih cepat)
        if ($length != -1) {
            $builder->limit($length,$start);
        }

        $rows = $builder->get()->getResultArray();

        // Format Output
        $data = [];
        $no = $start + 1;

        foreach ($rows as $r) {

            $year = substr($r['week_key'],0,4);
            $week = substr($r['week_key'],4);

            $hours = floor($r['total_minutes'] / 60);
            $minutes = $r['total_minutes'] % 60;

            $platformFee = $r['total_amount'] * 0.10;
            $grandTotal  = $r['total_amount'] + $platformFee;

            $name  = $r['hotel_name'];
            $short = mb_strlen($name) > 13
                ? mb_substr($name,0,13).'...'
                : $name;

            $data[] = [
                'no' => $no++.'.',
                'hotel' => '<span data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-custom-class="tooltip-primary" title="' . esc($name) . '"
                            >' . esc($short) . '</span>',
                'worker' => $r['workers'],
                'job' => 'Week '.$week.' / '.$year,
                'working_days' => $r['working_days'].' Days',
                'duration' => $hours.'h '.$minutes.'m',
                'amount' => 'Rp '.number_format($grandTotal,0,',','.'),
                'action' => '
                    <a href="'.base_url('/admin/invoices/create-week/'.$r['week_key'].'/'.$r['hotel_id']).'"
                       class="btn btn-sm btn-primary">
                       Create Invoice
                    </a>'
            ];
        }

        return $this->response->setJSON([
            'draw'=>$draw,
            'recordsTotal'=>$recordsTotal,
            'recordsFiltered'=>$recordsTotal,
            'data'=>$data
        ]);
    }
}