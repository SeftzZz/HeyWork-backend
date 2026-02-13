<?php

namespace App\Controllers\Admin;

use App\Models\JobAttendanceModel;
use App\Models\BalanceTransactionModel;
use CodeIgniter\Controller;

class Balance extends BaseAdminController
{
    protected $db;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);
        $this->db = \Config\Database::connect();
        $this->btModel = new BalanceTransactionModel();
    }

    /**
     * =========================================
     * HALAMAN BALANCE HOTEL
     * =========================================
     */
    public function index()
    {
        return view('admin/balance/index', [
            'title' => 'Hotel Balance'
        ]);
    }

    /**
     * =========================================
     * GET CURRENT BALANCE HOTEL
     * =========================================
     */
    public function getBalance()
    {
        $hotelId = session()->get('hotel_id');
        $balance = $this->calculateBalance($hotelId);

        return $this->response->setJSON([
            'status'  => true,
            'balance' => $balance
        ]);
    }


    /**
     * =========================================
     * TOPUP BALANCE HOTEL
     * =========================================
     */
    public function topup()
    {
        $hotelId = session()->get('hotel_id');
        $amount  = (float) $this->request->getPost('amount');

        if ($amount <= 0) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Invalid amount'
            ]);
        }

        $this->db->table('hotel_transactions')->insert([
            'hotel_id'   => $hotelId,
            'type'       => 'credit',
            'amount'     => $amount,
            'description'=> 'Manual Topup',
            'created_at' => date('Y-m-d H:i:s'),
            'created_by' => session('user_id')
        ]);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Balance successfully added'
        ]);
    }

    /**
     * =========================================
     * PAYROLL DEDUCTION (DEBIT)
     * =========================================
     */
    public function debit()
    {
        $hotelId = session()->get('hotel_id');
        $amount  = (float) $this->request->getPost('amount');
        $desc    = $this->request->getPost('description');

        if ($amount <= 0) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Invalid amount'
            ]);
        }

        $balance = $this->calculateBalance($hotelId);

        if ($balance < $amount) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Insufficient balance'
            ]);
        }

        $this->db->table('hotel_transactions')->insert([
            'hotel_id'   => $hotelId,
            'type'       => 'debit',
            'amount'     => $amount,
            'description'=> $desc ?? 'Payroll deduction',
            'created_at' => date('Y-m-d H:i:s'),
            'created_by' => session('user_id')
        ]);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Balance deducted successfully'
        ]);
    }

    private function calculateBalance($hotelId)
    {
        $credit = $this->db->table('hotel_transactions')
            ->selectSum('amount')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->get()
            ->getRow()
            ->amount ?? 0;

        $debit = $this->db->table('hotel_transactions')
            ->selectSum('amount')
            ->where('hotel_id', $hotelId)
            ->where('type', 'debit')
            ->get()
            ->getRow()
            ->amount ?? 0;

        return (float) $credit - (float) $debit;
    }

    public function monthlyJobStats()
    {
        $hotelId = session()->get('hotel_id') ?? 1;

        $rows = $this->db->table('job_attendances ja')
            ->select('
                j.id as job_id,
                j.position,
                COUNT(DISTINCT ja.application_id) as total_applications
            ')
            ->join('jobs j', 'j.id = ja.job_id', 'inner')
            ->where('j.hotel_id', $hotelId)
            ->groupBy('j.id')
            ->orderBy('total_applications', 'DESC')
            ->get()
            ->getResultArray();

        return $this->response->setJSON([
            'status' => true,
            'data'   => $rows
        ]);
    }

    /* =======================================================
     * UPDATE DAILY REVENUE (CREDIT + CATEGORY REVENUE)
     * ======================================================= */
    public function updateRevenue()
    {
        if (!in_array(session('user_role'), ['hotel_hr', 'admin'])) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Unauthorized'
            ]);
        }

        $hotelId = session()->get('hotel_id');
        $amount  = (float) $this->request->getPost('revenue');
        $today   = date('Y-m-d');

        if ($amount < 0) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Invalid revenue amount'
            ]);
        }

        // Cari revenue hari ini berdasarkan category
        $existing = $this->db->table('hotel_transactions')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('DATE(created_at)', $today)
            ->get()
            ->getRowArray();

        if ($existing) {

            $this->db->table('hotel_transactions')
                ->where('id', $existing['id'])
                ->update([
                    'amount'     => $amount,
                    'updated_at' => date('Y-m-d H:i:s'),
                    'updated_by' => session('user_id')
                ]);

        } else {

            $this->db->table('hotel_transactions')->insert([
                'hotel_id'   => $hotelId,
                'type'       => 'credit',
                'category'   => 'revenue',
                'amount'     => $amount,
                'description'=> 'Daily Revenue',
                'created_at' => date('Y-m-d H:i:s'),
                'created_by' => session('user_id')
            ]);
        }

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Revenue updated successfully'
        ]);
    }

    /* =======================================================
     * GET TODAY REVENUE
     * ======================================================= */
    public function getTodayRevenue()
    {
        $hotelId = session()->get('hotel_id');
        $today   = date('Y-m-d');

        $row = $this->db->table('hotel_transactions')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('DATE(created_at)', $today)
            ->get()
            ->getRowArray();

        return $this->response->setJSON([
            'status'  => true,
            'revenue' => (float) ($row['amount'] ?? 0)
        ]);
    }
}
