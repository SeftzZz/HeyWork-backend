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

        // CEK DUPLIKAT
        $existing = $db->table('invoices')
            ->where('hotel_id', $hotelId)
            ->where('week_key', $weekKey)
            ->get()
            ->getRow();

        // VALIDASI STATUS PAID
        if ($existing && $existing->status === 'paid') {
            return redirect()->to('/admin/invoices')
                ->with('error', 'Invoice already PAID and cannot be regenerated.');
        }

        // OVERTIME SUBQUERY
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

        // AMBIL DATA SHIFT
        $rows = $db->table('schedule_shifts ss')
            ->select("
                ss.application_id,
                ss.user_id as worker_id,
                u.name as worker_name,
                j.position,
                j.fee,

                GREATEST(
                    TIMESTAMPDIFF(
                        MINUTE,
                        CONCAT(sd.shift_date,' ',ss.start_time),
                        CONCAT(sd.shift_date,' ',ss.end_time)
                    ) - 60,
                    0
                ) AS shift_minutes,

                IFNULL(ot.overtime_minutes,0) AS overtime_minutes
            ")
            ->join('schedule_days sd','sd.id = ss.schedule_day_id','left')
            ->join('job_applications ja','ja.id = ss.application_id','left')
            ->join('users u','u.id = ss.user_id','left')
            ->join('jobs j','j.id = ja.job_id','left')
            ->join("($overtimeSub) ot",'ot.application_id = ss.application_id','left')

            ->where('j.hotel_id',$hotelId)
            ->whereIn('j.category',['daily_worker','casual'])
            ->whereIn('ss.shift_type',['regular','overtime'])
            ->where("YEARWEEK(sd.shift_date,1)",$weekKey)

            ->get()
            ->getResultArray();

        if(!$rows){
            return redirect()->back()->with('error','No shift data found');
        }

        // CALCULATION
        $invoiceItems = [];
        $totalAmount = 0;

        foreach($rows as $row){
            $shiftMinutes = (int)$row['shift_minutes'];
            $overtimeMinutes = (int)$row['overtime_minutes'];

            if($shiftMinutes <= 0) continue;

            $fee = (float)$row['fee'];

            // rate per minute
            $rate = $fee / $shiftMinutes;

            // worker fee
            $amountWorker = $fee + ($overtimeMinutes * $rate);

            // platform fee 10%
            $platformFee = $amountWorker * 0.10;

            // total
            $amount = $amountWorker + $platformFee;

            $totalMinutes = $shiftMinutes + $overtimeMinutes;

            $totalAmount += $amount;

            $invoiceItems[] = [
                'application_id' => $row['application_id'],
                'worker_id' => $row['worker_id'],
                'minutes' => $totalMinutes,
                'worker_fee' => $amountWorker,
                'platform_fee' => $platformFee
            ];
        }

        if(!$invoiceItems){
            return redirect()->back()->with('error','No billable shifts');
        }

        /*
        ==============================
        INSERT ATAU UPDATE INVOICE
        ==============================
        */
        if($existing){
            $invoiceId = $existing->id;
            // UPDATE INVOICE
            $db->table('invoices')
                ->where('id',$invoiceId)
                ->update([
                    'total_amount' => $totalAmount,
                    'updated_at' => date('Y-m-d H:i:s'),
                    'updated_by' => session()->get('user_id')
                ]);

            // HAPUS ITEM LAMA
            $db->table('invoice_items')
                ->where('invoice_id',$invoiceId)
                ->delete();
        }else{
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
        }

        // INSERT ITEM BARU
        foreach($invoiceItems as $item){
            $item['invoice_id'] = $invoiceId;
            $db->table('invoice_items')->insert($item);
        }
        $db->transComplete();

        if($db->transStatus() === false){
            return redirect()->back()->with('error','Invoice creation failed');
        }

        return redirect()->to('/admin/invoices')
            ->with('success','Invoice generated successfully');
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