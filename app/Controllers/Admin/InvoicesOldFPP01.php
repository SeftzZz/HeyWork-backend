<?php

namespace App\Controllers\Admin;

use App\Models\TransactionModel;
use App\Services\BillingService;
use Config\Snappy;

class Invoices extends BaseAdminController
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
        $hotelId  = session()->get('hotel_id');
        $userRole = session()->get('user_role');

        $builder = $this->transactionModel
            ->select('hotel_transactions.*, hotels.hotel_name, hotels.email')
            ->join('hotels', 'hotels.id = hotel_transactions.hotel_id', 'left')
            ->where('hotel_transactions.deleted_at', null)
            ->where('hotel_transactions.type', 'debit');

        if ($userRole === 'hotel_hr') {
            $builder->where('hotel_transactions.hotel_id', $hotelId);
        }

        $transactions = $builder
            ->orderBy('hotel_transactions.created_at', 'DESC')
            ->findAll();

        if (!$transactions) {
            return view('admin/invoices/index', [
                'invoice' => [
                    'id' => 0,
                    'created_at' => date('Y-m-d H:i:s'),
                    'hotel_name' => 'No Data',
                    'description' => 'No debit transactions',
                    'amount' => 0
                ]
            ]);
        }

        // Hitung total
        $total = 0;
        foreach ($transactions as $row) {
            $total += $row['amount'];
        }

        // Bentuk object invoice sesuai template
        $invoice = [
            'id'          => $hotelId,
            'created_at'  => date('Y-m-d H:i:s'),
            'hotel_name'  => $transactions[0]['hotel_name'],
            'hotel_email' => $transactions[0]['email'],
            'description' => 'Accumulated debit transactions',
            'amount'      => $total
        ];

        return view('admin/invoices/index', [
            'title'     => 'Invoices',
            'invoice'   => $invoice
        ]);
    }

    // ===================================================
    // DATATABLE (DEBIT ONLY = INVOICE)
    // ===================================================
    public function datatable()
    {
        $request = service('request');

        $searchValue = $request->getPost('search')['value'] ?? null;
        $length      = (int) $request->getPost('length');
        $start       = (int) $request->getPost('start');
        $order       = $request->getPost('order');

        $userRole = session()->get('user_role');
        $hotelId  = session()->get('hotel_id');

        // =========================
        // BASE BUILDER
        // =========================
        $builder = $this->transactionModel
            ->select('hotel_transactions.*, hotels.hotel_name')
            ->join('hotels', 'hotels.id = hotel_transactions.hotel_id', 'left')
            ->where('hotel_transactions.deleted_at', null)
            ->where('hotel_transactions.type', 'debit');

        if ($userRole === 'hotel_hr') {
            $builder->where('hotel_transactions.hotel_id', $hotelId);
        }

        // =========================
        // TOTAL RECORDS
        // =========================
        $recordsTotal = (clone $builder)->countAllResults();

        // =========================
        // SEARCH FILTER
        // =========================
        if ($searchValue) {
            $builder->groupStart()
                ->like('hotels.hotel_name', $searchValue)
                ->orLike('hotel_transactions.description', $searchValue)
                ->groupEnd();
        }

        $recordsFiltered = (clone $builder)->countAllResults();

        // =========================
        // ORDERING
        // =========================
        $orderColumns = [
            null,
            null,
            'hotels.hotel_name',
            'hotel_transactions.created_at',
            'hotel_transactions.amount',
            'hotel_transactions.description'
        ];

        if ($order) {
            $columnIndex = (int) $order[0]['column'];
            $dir         = $order[0]['dir'];

            if (!empty($orderColumns[$columnIndex])) {
                $builder->orderBy($orderColumns[$columnIndex], $dir);
            }
        } else {
            $builder->orderBy('hotel_transactions.created_at', 'DESC');
        }

        // =========================
        // LIMIT
        // =========================
        if ($length != -1) {
            $builder->limit($length, $start);
        }

        $data = $builder->get()->getResultArray();

        // =========================
        // FORMAT RESPONSE
        // =========================
        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {

            $result[] = [
                'no'          => $no++ . '.',
                'hotel'       => esc($row['hotel_name']),
                'date'        => date('d-m-Y', strtotime($row['created_at'])),
                'amount'      => 'Rp ' . number_format($row['amount'], 0, ',', '.'),
                'description' => esc($row['description']),
                'action'      => '
                    <a href="'.base_url('admin/invoices/create-week/'.$g['week_key']).'"
                        class="btn btn-sm btn-primary">
                        Create Weekly Invoice
                    </a>
                '
            ];
        }

        return $this->response->setJSON([
            'draw'            => (int) $request->getPost('draw'),
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $result
        ]);
    }

    public function print($applicationId)
    {
        $billing = new BillingService();
        $data = $billing->calculateApplication($applicationId);

        if (!$data) {
            return redirect()->back()->with('error', 'No attendance data found');
        }

        $invoice = [
            'id'          => $applicationId,
            'created_at'  => date('Y-m-d H:i:s'),
            'hotel_name'  => session()->get('hotel_name'),
            'description' => $data['position'] . ' - ' . $data['worker_name'],
            'amount'      => $data['total_amount']
        ];

        return view('admin/invoices/print', [
            'title'   => "Print Invoice",
            'invoice' => $invoice,
            'billing_detail' => $data
        ]);
    }

    public function create($applicationId)
    {
        $billing = new BillingService();
        $data = $billing->calculateApplication($applicationId);

        if (!$data) {
            return redirect()->back()->with('error', 'No attendance data found');
        }

        return view('admin/invoices/index', [
            'title'   => 'Invoice Detail',
            'invoice' => [
                'id'          => $applicationId,
                'created_at'  => date('Y-m-d H:i:s'),
                'hotel_name'  => session()->get('hotel_name'),
                'hotel_email' => session()->get('hotel_email'),
                'description' => $data['position'] . ' - ' . $data['worker_name'],
                'amount'      => $data['total_amount']
            ],
            'billing_detail' => $data
        ]);
    }

    public function sendEmail($applicationId)
    {
        $db = \Config\Database::connect();

        $billingService = new BillingService();
        $data = $billingService->calculateApplication($applicationId);

        if (!$data) {
            return redirect()->back()->with('error', 'No attendance data found');
        }

        // =========================
        // CEK SUDAH ADA INVOICE BELUM
        // =========================
        $existing = $db->table('invoice_items')
            ->where('application_id', $applicationId)
            ->get()
            ->getRowArray();

        if ($existing) {
            return redirect()->back()->with('error', 'Invoice already created for this application');
        }

        // =========================
        // AMBIL HOTEL
        // =========================
        $hotel = $db->table('hotels')
            ->where('id', $data['hotel_id'])
            ->get()
            ->getRowArray();

        $hotelName = $hotel['hotel_name'] ?? '';

        // =========================
        // GENERATE INVOICE NUMBER
        // =========================
        $invoiceNumber = 'INV-' . date('Ymd') . '-' . 'ID-' .$applicationId;

        // =========================
        // BILLING PERIOD
        // =========================
        $billingStart = date('Y-m-d', strtotime($data['checkins'][0] ?? date('Y-m-d')));
        $billingEnd   = date('Y-m-d', strtotime(end($data['checkouts']) ?? date('Y-m-d')));

        // =========================
        // INSERT INVOICE
        // =========================
        $db->table('invoices')->insert([
            'invoice_number' => $invoiceNumber,
            'hotel_id'       => $data['hotel_id'],
            'billing_start'  => $billingStart,
            'billing_end'    => $billingEnd,
            'total_amount'   => $data['total_amount'],
            'paid_amount'    => 0,
            'due_date'       => date('Y-m-d', strtotime('+7 days')),
            'created_by'     => session()->get('user_id')
        ]);

        $invoiceId = $db->insertID();

        // =========================
        // INSERT INVOICE ITEMS
        // =========================
        $count = min(count($data['checkins']), count($data['checkouts']));

        for ($i = 0; $i < $count; $i++) {

            $attendanceDate = date('Y-m-d', strtotime($data['checkins'][$i]));

            // hitung amount per hari
            $seconds = strtotime($data['checkouts'][$i]) - strtotime($data['checkins'][$i]);
            $minutes = floor($seconds / 60);

            if ($minutes <= 0) continue;

            $jobStart   = strtotime($data['start_time']);
            $jobEnd     = strtotime($data['end_time']);
            $jobMinutes = ($jobEnd - $jobStart) / 60;
            $jobTenMin  = floor($jobMinutes / 10);

            $amount = 0;

            if ($jobTenMin > 0 && $data['fee'] > 0) {
                $ratePer10Min = $data['fee'] / $jobTenMin;
                $amount = round(floor($minutes / 10) * $ratePer10Min);
            }

            $db->table('invoice_items')->insert([
                'invoice_id'     => $invoiceId,
                // 'transaction_id' => null,
                'amount'         => $amount,
                'application_id' => $applicationId,
                'attendance_date'=> $attendanceDate
            ]);
        }

        // =========================
        // GENERATE PDF
        // =========================
        $invoice = [
            'id'          => $invoiceId,
            'created_at'  => date('Y-m-d H:i:s'),
            'hotel_name'  => $hotelName,
            'description' => $data['position'] . ' - ' . $data['worker_name'],
            'amount'      => $data['total_amount']
        ];

        $pdf = Snappy::pdf();

        $html = view('admin/invoices/print', [
            'title'   => "Invoice PDF",
            'invoice' => $invoice,
            'billing_detail' => $data
        ]);

        $output = $pdf->getOutputFromHtml($html);

        $fileName = $invoiceNumber . '.pdf';
        $filePath = WRITEPATH . 'uploads/invoices/' . $fileName;

        file_put_contents($filePath, $output);

        // =========================
        // SEND EMAIL
        // =========================
        $email = service('invoiceEmail');

        $email->setFrom('yourgmail@gmail.com', $hotelName);
        $email->setTo('aryaseftzzz@gmail.com');
        $email->setSubject('Invoice ' . $invoiceNumber);

        $email->setMessage("
            Dear HeyWork,<br><br>
            We have generated a new invoice in the amount of: Rp " . number_format($invoice['amount'],0,',','.') . "<br>
            Please find attached invoice for worker:<br>
            <strong>{$data['worker_name']}</strong><br><br>
            Please process payment at your earliest convenience.<br><br>
            Regards,<br>
            {$hotelName}
        ");

        $email->attach($filePath);

        if ($email->send()) {

            // Update status ke SENT
            $db->table('invoices')
                ->where('id', $invoiceId)
                ->update(['status' => 'sent']);

            return redirect()->back()->with('success', 'Invoice created and email sent');
        }

        return redirect()->back()->with('error', 'Invoice created but email failed');
    }

    // ===================================================
    // CREATE WEEKLY INVOICE
    // ===================================================
    public function createWeekly($weekKey, $hotelId)
    {
        $db = \Config\Database::connect();
        $db->transStart();

        // =====================================
        // CEK INVOICE SUDAH ADA ATAU BELUM
        // =====================================
        $existing = $db->table('invoices')
            ->where('hotel_id', $hotelId)
            ->where('week_key', $weekKey)
            ->get()
            ->getRow();

        if ($existing) {
            return redirect()->back()->with('error','Invoice for this week already exists');
        }

        // =====================================
        // AMBIL DATA ATTENDANCE
        // =====================================
        $rows = $db->table('job_attendances')
            ->select("
                job_attendances.application_id,
                job_attendances.type,
                job_attendances.created_at,
                users.id as worker_id,
                users.name AS worker_name,
                jobs.position,
                jobs.fee,
                schedule_shifts.start_time,
                schedule_shifts.end_time,
                schedule_days.shift_date
            ")
            ->join('job_applications','job_applications.id = job_attendances.application_id','left')
            ->join('users','users.id = job_applications.user_id','left')
            ->join('jobs','jobs.id = job_applications.job_id','left')
            ->join('schedule_shifts',
                'schedule_shifts.application_id = job_attendances.application_id
                 AND schedule_shifts.user_id = job_applications.user_id','left')
            ->join('schedule_days','schedule_days.id = schedule_shifts.schedule_day_id','left')

            ->where('jobs.hotel_id',$hotelId)
            ->where('job_applications.status','completed')

            ->where("YEARWEEK(schedule_days.shift_date,1)", $weekKey)

            ->orderBy('job_attendances.application_id','ASC')
            ->orderBy('job_attendances.created_at','ASC')

            ->get()
            ->getResultArray();


        if(!$rows){
            return redirect()->back()->with('error','No attendance data found');
        }

        // =====================================
        // GROUPING DATA
        // =====================================
        $apps = [];
        foreach($rows as $row){
            $appId = $row['application_id'];
            if(!isset($apps[$appId])){
                $apps[$appId] = [
                    'worker_id' => $row['worker_id'],
                    'worker_name' => $row['worker_name'],
                    'position' => $row['position'],
                    'fee' => $row['fee'],
                    'start_time' => $row['start_time'],
                    'end_time' => $row['end_time'],
                    'checkins' => [],
                    'checkouts' => [],
                    'minutes' => 0,
                    'amount' => 0
                ];
            }

            if($row['type'] === 'checkin'){
                $apps[$appId]['checkins'][] = $row['created_at'];
            }

            if($row['type'] === 'checkout'){
                $apps[$appId]['checkouts'][] = $row['created_at'];
            }
        }

        // =====================================
        // HITUNG JAM KERJA
        // =====================================
        $invoiceItems = [];
        $totalAmount  = 0;

        foreach($apps as $appId => &$app){
            $count = min(count($app['checkins']),count($app['checkouts']));
            for($i=0;$i<$count;$i++){
                $seconds = max(
                    0,
                    (strtotime($app['checkouts'][$i]) - strtotime($app['checkins'][$i])) - 3600
                );
                $minutes = floor($seconds/60);
                if($minutes <= 0){
                    continue;
                }
                $app['minutes'] += $minutes;
                $jobStart = strtotime($app['start_time']);
                $jobEnd   = strtotime($app['end_time']);
                $jobMinutes = ($jobEnd - $jobStart)/60;
                $jobTenMin = floor($jobMinutes/10);
                if($jobTenMin > 0 && $app['fee'] > 0){

                    $ratePer10Min = $app['fee'] / $jobTenMin;

                    $amount = round(
                        floor($minutes/10) * $ratePer10Min
                    );

                    $app['amount'] += $amount;
                }
            }

            if($app['amount'] <= 0){
                continue;
            }

            $totalAmount += $app['amount'];
            $invoiceItems[] = [
                'application_id' => $appId,
                'worker_id' => $app['worker_id'],
                'minutes' => $app['minutes'],
                'amount' => $app['amount']
            ];
        }

        if(!$invoiceItems){
            return redirect()->back()->with('error','No billable attendance found');
        }

        // =====================================
        // GENERATE INVOICE NUMBER
        // =====================================
        $invoiceNumber = 'INV-'.$hotelId.'-'.$weekKey.'-'.time();

        // =====================================
        // INSERT INVOICE
        // =====================================
        $db->table('invoices')->insert([
            'invoice_number' => $invoiceNumber,
            'hotel_id' => $hotelId,
            'week_key' => $weekKey,
            'total_amount' => $totalAmount,
            'status' => 'draft',
            'created_at' => date('Y-m-d H:i:s'),
            'created_by' => session()->get('user_id')
        ]);

        $invoiceId = $db->insertID();

        // =====================================
        // INSERT ITEMS
        // =====================================
        foreach($invoiceItems as $item){
            $item['invoice_id'] = $invoiceId;
            $db->table('invoice_items')->insert($item);
        }

        $applicationIds = array_column($invoiceItems,'application_id');

        $db->table('job_attendances')
           ->whereIn('application_id', $applicationIds)
           ->update(['billed' => 1]);

        $db->transComplete();
        if($db->transStatus() === false){
            return redirect()->back()->with('error','Invoice creation failed');
        }

        return redirect()->to('/admin/invoices/view/'.$invoiceId)
            ->with('success','Weekly invoice created successfully');
    }

    public function view($id)
    {
        $db = \Config\Database::connect();

        // =========================
        // GET INVOICE
        // =========================
        $invoice = $db->table('invoices')
            ->select('invoices.*, hotels.hotel_name, hotels.email as hotel_email')
            ->join('hotels', 'hotels.id = invoices.hotel_id')
            ->where('invoices.id', $id)
            ->get()
            ->getRowArray();

        // jika invoice tidak ditemukan
        if (!$invoice) {
            return redirect()->to('/admin/invoices')
                ->with('error', 'Invoice not found');
        }

        // =========================
        // GET INVOICE ITEMS
        // =========================
        $items = $db->table('invoice_items')
            ->select('invoice_items.*, users.name as worker_name, jobs.position')
            ->join('users', 'users.id = invoice_items.worker_id')
            ->join('job_applications', 'job_applications.id = invoice_items.application_id')
            ->join('jobs', 'jobs.id = job_applications.job_id')
            ->where('invoice_items.invoice_id', $id)
            ->get()
            ->getResultArray();

        // =========================
        // RETURN VIEW
        // =========================
        return view('admin/invoices/view', [
            'title'   => 'Invoice Detail',
            'invoice' => $invoice,
            'items'   => $items
        ]);
    }
}