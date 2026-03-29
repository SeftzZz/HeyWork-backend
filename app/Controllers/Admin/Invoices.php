<?php

namespace App\Controllers\Admin;

use App\Models\InvoiceModel;
use Dompdf\Dompdf;
use Dompdf\Options;

class Invoices extends BaseAdminController
{
    protected $invoiceModel;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);
        $this->invoiceModel = new InvoiceModel();
    }

    public function index()
    {
        $data = [
            'title'  => 'Invoices'
        ];

        return view('admin/invoices/index', $data);
    }

    // ===============================
    // DATATABLE SERVER SIDE - INVOICES
    // ===============================
    public function datatable()
    {
        $request = service('request');

        $searchValue = $request->getPost('search')['value'] ?? null;
        $length = (int) $request->getPost('length');
        $start  = (int) $request->getPost('start');

        $hotelId = session()->get('hotel_id');
        $userRole = session()->get('user_role');

        $db = \Config\Database::connect();
        $builder = $db->table('invoices')
            ->select('invoices.*, hotels.hotel_name')
            ->join('hotels','hotels.id=invoices.hotel_id','left');

        // =========================
        // FILTER HOTEL
        // =========================
        if ($hotelId != 0) {
            $builder->where('invoices.hotel_id', $hotelId);
        }

        // =========================
        // SEARCH
        // =========================
        if ($searchValue) {
            $builder->groupStart()
                ->like('invoice_number', $searchValue)
                ->orLike('hotels.hotel_name', $searchValue)
                ->orLike('status', $searchValue)
            ->groupEnd();
        }

        // =========================
        // SORTING DATATABLE
        // =========================

        $columnOrder = [
            null,
            null,
            'invoice_number',
            'hotels.hotel_name',
            'week_key',
            'total_amount',
            'status',
            'created_at',
            null
        ];

        $order = $request->getPost('order');

        if ($order) {
            $columnIndex = $order[0]['column'];
            $dir = $order[0]['dir'];

            if (isset($columnOrder[$columnIndex]) && $columnOrder[$columnIndex] != null) {
                $builder->orderBy($columnOrder[$columnIndex], $dir);
            }
        } else {
            $builder->orderBy('created_at','DESC');
        }

        // =========================
        // COUNT FILTERED
        // =========================
        $recordsFiltered = $builder->countAllResults(false);

        // =========================
        // DATA
        // =========================
        $data = $builder
            ->limit($length,$start)
            ->get()
            ->getResultArray();

        // =========================
        // TOTAL RECORD
        // =========================
        $totalBuilder = $this->invoiceModel;

        if ($hotelId != 0) {
            $totalBuilder->where('hotel_id', $hotelId);
        }

        $recordsTotal = $totalBuilder->countAllResults();

        // =========================
        // FORMAT RESULT
        // =========================
        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {
            $year = substr($row['week_key'],0,4);
            $week = substr($row['week_key'],4);

            $weekLabel = "Week ".$week." / ".$year;

            $statusClass = match($row['status']){
                'paid' => 'bg-label-success',
                'sent' => 'bg-label-info',
                'partial' => 'bg-label-warning',
                'overdue' => 'bg-label-danger',
                default => 'bg-label-secondary'
            };

            $action = '
                <button
                    class="btn btn-icon btn-primary btn-view-invoice"
                    data-id="'.$row['id'].'"
                    data-bs-toggle="tooltip" data-bs-custom-class="tooltip-primary"
                    title="View"><i class="ti ti-eye"></i>
                </button>
            ';
            if ($userRole === 'admin') {
                 $action .= '
                    <button class="btn btn-icon btn-primary btn-edit" data-id="'.$row['id'].'" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="tooltip-primary" title="Edit">
                        <i class="ti ti-pencil"></i>
                    </button>
                 ';
            }

            $result[] = [
                'no_urut' => $no++ . '.',
                'invoice_number' => esc($row['invoice_number']),
                'hotel' => esc($row['hotel_name']),
                'week' => $weekLabel,
                'amount' => 'Rp '.number_format($row['total_amount'],0,',','.'),
                'status' => '<span class="badge '.$statusClass.'">'
                            .strtoupper($row['status']).'</span>',
                'created_at' => date('d M Y',strtotime($row['created_at'])),
                'action' => $action
            ];
        }

        return $this->response->setJSON([
            'draw' => (int)$request->getPost('draw'),
            'recordsTotal' => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data' => $result
        ]);
    }

    // ===================================================
    // CREATE WEEKLY INVOICE
    // ===================================================
    public function createWeekly($weekKey, $hotelId)
    {
        $db = \Config\Database::connect();
        $db->transStart();

        // =====================================
        // CEK DUPLIKAT INVOICE
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
        // AMBIL DATA (SAMA SEPERTI DATATABLE)
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
                jobs.hotel_id,
                schedule_shifts.start_time,
                schedule_shifts.end_time
            ")
            ->join('job_applications','job_applications.id = job_attendances.application_id','left')
            ->join('users','users.id = job_applications.user_id','left')
            ->join('jobs','jobs.id = job_applications.job_id','left')
            ->join(
                'schedule_shifts',
                'schedule_shifts.application_id = job_attendances.application_id
                 AND schedule_shifts.user_id = job_applications.user_id',
                'left'
            )

            ->where('jobs.hotel_id',$hotelId)
            ->whereIn('jobs.category',['daily_worker','casual'])
            ->where('job_applications.status','completed')
            ->where('job_attendances.billed',0)

            // 🔥 SAMA DENGAN DATATABLE
            ->where("YEARWEEK(job_attendances.created_at,1)", $weekKey)

            ->orderBy('job_attendances.application_id','ASC')
            ->orderBy('job_attendances.created_at','ASC')

            ->get()
            ->getResultArray();

        if(!$rows){
            return redirect()->back()->with('error','No attendance data found');
        }

        // =====================================
        // GROUPING (ANTI DUPLICATE - BY DATE)
        // =====================================
        $apps = [];

        foreach($rows as $row){

            $appId = $row['application_id'];

            if(!isset($apps[$appId])){
                $apps[$appId] = [
                    'worker_id' => $row['worker_id'],
                    'worker_name' => $row['worker_name'],
                    'position' => $row['position'],
                    'fee' => (float)$row['fee'],
                    'start_time' => $row['start_time'],
                    'end_time' => $row['end_time'],
                    'checkins' => [],
                    'checkouts' => [],
                    'minutes' => 0,
                    'amount' => 0
                ];
            }

            $date = date('Y-m-d', strtotime($row['created_at']));

            if($row['type'] === 'checkin'){
                $apps[$appId]['checkins'][$date] = $row['created_at'];
            }

            if($row['type'] === 'checkout'){
                $apps[$appId]['checkouts'][$date] = $row['created_at'];
            }
        }

        // =====================================
        // CALCULATION (SAMA PERSIS DENGAN DATATABLE)
        // =====================================
        $invoiceItems = [];
        $totalAmount  = 0;

        foreach($apps as $appId => &$app){

            if (!$app['start_time'] || !$app['end_time']) continue;

            $jobStart = strtotime($app['start_time']);
            $jobEnd   = strtotime($app['end_time']);

            if (!$jobStart || !$jobEnd) continue;

            // 🔥 POTONG 1 JAM (WAJIB SAMA)
            $jobMinutes = (($jobEnd - $jobStart) / 60) - 60;

            if ($jobMinutes <= 0) continue;

            $jobTenMin = floor($jobMinutes / 10);

            if ($jobTenMin <= 0 || $app['fee'] <= 0) continue;

            $ratePer10Min = $app['fee'] / $jobTenMin;

            foreach($app['checkins'] as $date => $checkin){

                if(!isset($app['checkouts'][$date])) continue;

                $checkout = $app['checkouts'][$date];

                $seconds = max(
                    0,
                    (strtotime($checkout) - strtotime($checkin)) - 3600
                );

                $minutes = floor($seconds / 60);

                if($minutes <= 0) continue;

                $app['minutes'] += $minutes;

                $amount = round(
                    floor($minutes / 10) * $ratePer10Min
                );

                $app['amount'] += $amount;
            }

            if($app['amount'] <= 0) continue;

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
        // INSERT INVOICE
        // =====================================
        $invoiceNumber = 'INV-'.$hotelId.'-'.$weekKey.'-'.time();

        $db->table('invoices')->insert([
            'invoice_number' => $invoiceNumber,
            'hotel_id' => $hotelId,
            'week_key' => $weekKey,
            'total_amount' => $totalAmount,
            'status' => 'unpaid',
            'created_at' => date('Y-m-d H:i:s'),
            'created_by' => session()->get('user_id')
        ]);

        $invoiceId = $db->insertID();

        foreach($invoiceItems as $item){
            $item['invoice_id'] = $invoiceId;
            $db->table('invoice_items')->insert($item);
        }

        // =====================================
        // UPDATE BILLED
        // =====================================
        $applicationIds = array_column($invoiceItems,'application_id');

        $db->table('job_attendances')
           ->whereIn('application_id', $applicationIds)
           ->update(['billed' => 1]);

        $db->transComplete();

        if($db->transStatus() === false){
            return redirect()->back()->with('error','Invoice creation failed');
        }

        return redirect()->to('/admin/invoices')
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
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Invoice not found'
            ]);
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
        return view('admin/invoices/modal_view', [
            'invoice' => $invoice,
            'items' => $items
        ]);
    }

    public function print($id)
    {
        $db = \Config\Database::connect();
        $invoice = $db->table('invoices')
            ->select('invoices.*, hotels.hotel_name, hotels.email as hotel_email')
            ->join('hotels', 'hotels.id = invoices.hotel_id')
            ->where('invoices.id', $id)
            ->get()
            ->getRowArray();

        if (!$invoice) {
            return redirect()->to('/admin/invoices')
                ->with('error','Invoice not found');
        }

        $items = $db->table('invoice_items')
            ->select('invoice_items.*, users.name as worker_name, jobs.position')
            ->join('users','users.id = invoice_items.worker_id')
            ->join('job_applications','job_applications.id = invoice_items.application_id')
            ->join('jobs','jobs.id = job_applications.job_id')
            ->where('invoice_items.invoice_id',$id)
            ->get()
            ->getResultArray();

        $html = view('admin/invoices/pdf_file',[
            'invoice' => $invoice,
            'items' => $items
        ]);

        $options = new Options();
        $options->set('isRemoteEnabled', true);
        $dompdf = new Dompdf($options);
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4','portrait');
        $dompdf->render();
        $filename = 'Invoice-'.$invoice['invoice_number'].'.pdf';
        $dompdf->stream($filename, [
            "Attachment" => true
        ]);
    }

    public function printView($id)
    {
        $db = \Config\Database::connect();

        $invoice = $db->table('invoices')
            ->select('invoices.*, hotels.hotel_name, hotels.email as hotel_email')
            ->join('hotels', 'hotels.id = invoices.hotel_id')
            ->where('invoices.id', $id)
            ->get()
            ->getRowArray();

        if (!$invoice) {
            return redirect()->to('/admin/invoices')
                ->with('error', 'Invoice not found');
        }

        $items = $db->table('invoice_items')
            ->select('invoice_items.*, users.name as worker_name, jobs.position')
            ->join('users', 'users.id = invoice_items.worker_id')
            ->join('job_applications', 'job_applications.id = invoice_items.application_id')
            ->join('jobs', 'jobs.id = job_applications.job_id')
            ->where('invoice_items.invoice_id', $id)
            ->get()
            ->getResultArray();

        return view('admin/invoices/print_inv', [
            'invoice' => $invoice,
            'items' => $items
        ]);
    }

    // ===============================
    // GET BY ID
    // ===============================
    public function getById()
    {
        $id = $this->request->getPost('id');
        $db = \Config\Database::connect();
        $invoice = $db->table('invoices')
            ->select('invoices.*, hotels.hotel_name')
            ->join('hotels','hotels.id = invoices.hotel_id','left')
            ->where('invoices.id',$id)
            ->get()
            ->getRowArray();

        if (!$invoice) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Data not found'
            ]);
        }

        return $this->response->setJSON([
            'status' => true,
            'data' => $invoice
        ]);
    }

    // ===============================
    // UPDATE
    // ===============================
    public function update()
    {
        if (!$this->request->isAJAX()) {
            return $this->response->setStatusCode(404);
        }

        $id       = $this->request->getPost('id');
        $status   = $this->request->getPost('status');

        $invoice = $this->invoiceModel->find($id);

        if (!$invoice) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Data not found'
            ]);
        }

        // UPDATE DATA
        $data = [
            'status'    => $status
        ];

        $this->invoiceModel->update($id, $data);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Invoice successfully updated'
        ]);
    }
}