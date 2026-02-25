<?php

namespace App\Controllers\Admin;

use App\Models\JobAttendanceModel;
use App\Models\BalanceTransactionModel;
use CodeIgniter\Controller;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;
use PhpOffice\PhpSpreadsheet\Style\Fill;

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


    /* =======================================================
     * HISTORY TRANSACTIONS (WAJIB INCLUDE CATEGORY)
     * ======================================================= */
    public function history()
    {
        $hotelId = session()->get('hotel_id');

        $rows = $this->db->table('hotel_transactions')
            ->select('id, hotel_id, type, category, amount, description, created_at')
            ->where('hotel_id', $hotelId)
            ->orderBy('created_at', 'DESC')
            ->get()
            ->getResultArray();

        return $this->response->setJSON([
            'status' => true,
            'data'   => $rows
        ]);
    }
    
    /* =======================================================
     * BALANCE CALCULATION (SEMUA CREDIT - SEMUA DEBIT)
     * ======================================================= */
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

        $yesterdayStart = date('Y-m-d 00:00:00', strtotime('-1 day'));
        $yesterdayEnd   = date('Y-m-d 23:59:59', strtotime('-1 day'));

        $rows = $this->db->table('job_attendances ja')
            ->select('
                j.id as job_id,
                j.position,
                COUNT(DISTINCT ja.application_id) as total_applications
            ')
            ->join('jobs j', 'j.id = ja.job_id', 'inner')
            ->where('j.hotel_id', $hotelId)
            ->where('ja.created_at >=', $yesterdayStart)
            ->where('ja.created_at <=', $yesterdayEnd)
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
        $revenue = (float) $this->request->getPost('revenue');

        if ($revenue < 0) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Invalid revenue amount'
            ]);
        }

        $attendanceDate = date('Y-m-d', strtotime('-1 day'));
        $start = $attendanceDate . ' 00:00:00';
        $end   = $attendanceDate . ' 23:59:59';
        $daysInMonth = date('t', strtotime($attendanceDate));

        $this->db->transStart();

        $payrollRows = $this->db->table('job_attendances ja')
            ->select('
                j.id as job_id,
                j.category as job_category,
                j.fee,
                wc.base_salary,
                COUNT(DISTINCT ja.application_id) as total_applications,
                COUNT(DISTINCT ja.user_id) as total_workers
            ')
            ->join('jobs j', 'j.id = ja.job_id', 'inner')
            ->join('worker_contracts wc',
                   'wc.user_id = ja.user_id AND wc.contract_type = "corporate"',
                   'left')
            ->where('j.hotel_id', $hotelId)
            ->where('ja.created_at >=', $start)
            ->where('ja.created_at <=', $end)
            ->groupBy('j.id')
            ->get()
            ->getResultArray();

        $totalPayroll = 0;

        foreach ($payrollRows as $row) {

            if ($row['job_category'] === 'daily_worker') {

                $dw = (int)$row['total_applications'];
                $cost = $dw * (float)$row['fee'];

            } elseif ($row['job_category'] === 'corporate') {

                $dw = (int)$row['total_workers'];
                $dailySalary = (float)$row['base_salary'] / $daysInMonth;
                $cost = $dw * $dailySalary;

            } else {
                $cost = 0;
            }

            $totalPayroll += $cost;
        }

        $dwRatio = $revenue > 0 ? ($totalPayroll / $revenue) * 100 : 0;
        $dwRounded = round($dwRatio, 2);

        $ratioLabel = 'NO DATA';
        if ($dwRatio >= 6 && $dwRatio <= 10) $ratioLabel = 'GOOD';
        elseif ($dwRatio > 10 && $dwRatio <= 12) $ratioLabel = 'AVERAGE';
        elseif ($dwRatio > 12 && $dwRatio <= 15) $ratioLabel = 'BAD';
        elseif ($dwRatio > 15) $ratioLabel = 'NOT OPTIMAL MAN POWER';

        $payrollTransactionId = null;

        if ($totalPayroll > 0) {

            $existingPayroll = $this->db->table('hotel_transactions')
                ->where('hotel_id', $hotelId)
                ->where('type', 'debit')
                ->where('category', 'payroll')
                ->where('date', $attendanceDate)
                ->get()
                ->getRowArray();

            if ($existingPayroll) {

                $payrollTransactionId = $existingPayroll['id'];

                $this->db->table('hotel_transactions')
                    ->where('id', $payrollTransactionId)
                    ->update([
                        'amount'     => $totalPayroll,
                        'updated_at' => date('Y-m-d H:i:s'),
                        'updated_by' => session('user_id')
                    ]);

            } else {

                $this->db->table('hotel_transactions')->insert([
                    'hotel_id'   => $hotelId,
                    'type'       => 'debit',
                    'category'   => 'payroll',
                    'amount'     => $totalPayroll,
                    'date'       => $attendanceDate,
                    'description'=> 'Auto Payroll Deduction H-1',
                    'created_at' => date('Y-m-d H:i:s'),
                    'created_by' => session('user_id')
                ]);

                $payrollTransactionId = $this->db->insertID();
            }

            if ($payrollTransactionId) {

                $this->db->table('job_attendances')
                    ->where('created_at >=', $start)
                    ->where('created_at <=', $end)
                    ->update([
                        'transaction_id' => $payrollTransactionId
                    ]);
            }
        }

        $existingRevenue = $this->db->table('hotel_transactions')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('date', $attendanceDate)
            ->get()
            ->getRowArray();

        if ($existingRevenue) {

            $this->db->table('hotel_transactions')
                ->where('id', $existingRevenue['id'])
                ->update([
                    'amount'     => $revenue,
                    'dw_ratio'   => $dwRounded,
                    'dw_label'   => $ratioLabel,
                    'updated_at' => date('Y-m-d H:i:s'),
                    'updated_by' => session('user_id')
                ]);

        } else {

            $this->db->table('hotel_transactions')->insert([
                'hotel_id'   => $hotelId,
                'type'       => 'credit',
                'category'   => 'revenue',
                'amount'     => $revenue,
                'dw_ratio'   => $dwRounded,
                'dw_label'   => $ratioLabel,
                'date'       => $attendanceDate,
                'description'=> 'Daily Revenue H-1',
                'created_at' => date('Y-m-d H:i:s'),
                'created_by' => session('user_id')
            ]);
        }

        $this->db->transComplete();

        return $this->response->setJSON([
            'status'        => true,
            'message'       => 'Revenue & payroll updated successfully',
            'date'          => $attendanceDate,
            'total_payroll' => $totalPayroll,
            'dw_ratio'      => $dwRounded,
            'dw_label'      => $ratioLabel
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

    public function dailyReport()
    {
        $hotelId = session()->get('hotel_id');
        $type = $this->request->getGet('type') ?? 'all';

        $attendanceDate = date('Y-m-d', strtotime('-1 day'));
        $start = $attendanceDate . ' 00:00:00';
        $end   = $attendanceDate . ' 23:59:59';
        $daysInMonth = date('t', strtotime($attendanceDate));

        // ======================
        // Filter Category
        // ======================
        $allowedTypes = ['daily_worker', 'corporate', 'all'];
        if (!in_array($type, $allowedTypes)) {
            $type = 'all';
        }

        // ======================
        // Departments
        // ======================
        $departmentsRaw = $this->db->table('skills')
            ->select('DISTINCT(category) as category')
            ->orderBy('category', 'ASC')
            ->get()
            ->getResultArray();

        // ======================
        // Attendance Query
        // ======================
        $builder = $this->db->table('job_attendances ja')
            ->select('
                s.category,
                j.category as job_category,
                j.fee,
                wc.base_salary,
                COUNT(DISTINCT ja.application_id) as total_applications,
                COUNT(DISTINCT ja.user_id) as total_workers
            ')
            ->join('jobs j', 'j.id = ja.job_id')
            ->join('skills s', 's.name = j.position', 'left')
            ->join('worker_contracts wc',
                   'wc.user_id = ja.user_id AND wc.contract_type = "corporate"',
                   'left')
            ->where('j.hotel_id', $hotelId)
            ->where('ja.created_at >=', $start)
            ->where('ja.created_at <=', $end)
            ->groupBy('j.id');

        if ($type !== 'all') {
            $builder->where('j.category', $type);
        }

        $attendanceRows = $builder->get()->getResultArray();

        $attendanceMap = [];
        $totalCost = 0;

        foreach ($attendanceRows as $row) {

            $category = $row['category'] ?? 'Uncategorized';

            if ($row['job_category'] === 'daily_worker') {

                $dw = (int)$row['total_applications'];
                $cost = $dw * (float)$row['fee'];

            } elseif ($row['job_category'] === 'corporate') {

                $dw = (int)$row['total_workers'];
                $dailySalary = (float)$row['base_salary'] / $daysInMonth;
                $cost = $dw * $dailySalary;

            } else {
                $dw = 0;
                $cost = 0;
            }

            $totalCost += $cost;

            if (!isset($attendanceMap[$category])) {
                $attendanceMap[$category] = [
                    'dw' => 0,
                    'cost' => 0
                ];
            }

            $attendanceMap[$category]['dw'] += $dw;
            $attendanceMap[$category]['cost'] += $cost;
        }

        $departments = [];

        foreach ($departmentsRaw as $dep) {

            $category = $dep['category'];

            $departments[] = [
                'department' => $category,
                'dw' => $attendanceMap[$category]['dw'] ?? 0,
                'cost' => $attendanceMap[$category]['cost'] ?? 0
            ];
        }

        // ======================
        // Revenue (GLOBAL)
        // ======================
        $revenueRow = $this->db->table('hotel_transactions')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('date', $attendanceDate)
            ->get()
            ->getRowArray();

        $todayRevenue = (float)($revenueRow['amount'] ?? 0);

        // ======================
        // TODAY RATIO (SEGMENT AWARE)
        // ======================
        $todayRatio = $todayRevenue > 0
            ? round(($totalCost / $todayRevenue) * 100, 2)
            : 0;

        $todayLabel = $this->getRatioLabel($todayRatio, $hotelId);

        // ======================
        // MTD
        // ======================
        $monthStart = date('Y-m-01');

        $mtdRevenue = $this->db->table('hotel_transactions')
            ->selectSum('amount')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('date >=', $monthStart)
            ->where('date <=', $attendanceDate)
            ->get()
            ->getRow()
            ->amount ?? 0;

        $mtdRatio = $mtdRevenue > 0
            ? round(($totalCost / $mtdRevenue) * 100, 2)
            : 0;

        $mtdLabel = $this->getRatioLabel($mtdRatio, $hotelId);

        return $this->response->setJSON([
            'status' => true,
            'date' => $attendanceDate,
            'departments' => $departments,
            'total_dw_cost' => $totalCost,
            'today_revenue' => $todayRevenue,
            'today_ratio' => $todayRatio,
            'today_label' => $todayLabel,
            'mtd_revenue' => (float)$mtdRevenue,
            'mtd_ratio' => $mtdRatio,
            'mtd_label' => $mtdLabel
        ]);
    }

    public function exportReportXlsx()
    {
        $hotelId = session()->get('hotel_id');

        $dateRows = $this->db->table('hotel_transactions')
            ->select('DISTINCT(date) as date')
            ->where('hotel_id', $hotelId)
            ->where('category', 'revenue')
            ->orderBy('date', 'ASC')
            ->get()
            ->getResultArray();

        $dateList = array_column($dateRows, 'date');

        if (empty($dateList)) {
            return redirect()->back();
        }

        $departmentsRaw = $this->db->table('skills')
            ->select('DISTINCT(category) as category')
            ->orderBy('category', 'ASC')
            ->get()
            ->getResultArray();

        $spreadsheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
        $sheet->setTitle('Daily Report');

        // ================= HEADER =================
        $sheet->setCellValue('A1', 'Department');

        $colIndex = 2;
        foreach ($dateList as $date) {

            $formatted = date('d-M-y', strtotime($date));

            $startCol = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex);
            $endCol   = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex + 1);

            $sheet->setCellValue($startCol.'1', $formatted);
            $sheet->mergeCells($startCol.'1:'.$endCol.'1');

            $sheet->setCellValue($startCol.'2', 'DW');
            $sheet->setCellValue($endCol.'2', 'Cost');

            $colIndex += 2;
        }

        $sheet->getStyle('A1:'.$sheet->getHighestColumn().'2')->getFont()->setBold(true);
        $sheet->getStyle('A1:'.$sheet->getHighestColumn().'2')
            ->getAlignment()
            ->setHorizontal(\PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER);

        // ================= DATA PER DEPARTMENT =================
        $rowIndex = 3;

        foreach ($departmentsRaw as $dep) {

            $category = $dep['category'];
            $sheet->setCellValue('A'.$rowIndex, $category);

            $colIndex = 2;

            foreach ($dateList as $date) {

                $rows = $this->db->table('job_attendances ja')
                    ->select('COUNT(DISTINCT ja.application_id) as dw, SUM(j.fee) as total')
                    ->join('jobs j', 'j.id = ja.job_id')
                    ->join('skills s', 's.name = j.position', 'left')
                    ->where('j.hotel_id', $hotelId)
                    ->where('s.category', $category)
                    ->where('DATE(ja.created_at)', $date)
                    ->get()
                    ->getRowArray();

                $dw    = (int)($rows['dw'] ?? 0);
                $total = (float)($rows['total'] ?? 0);

                $colDW   = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex);
                $colCost = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex + 1);

                $sheet->setCellValue($colDW.$rowIndex, $dw > 0 ? $dw : '-');
                $sheet->setCellValue($colCost.$rowIndex, $total > 0 ? $total : '-');

                $colIndex += 2;
            }

            $rowIndex++;
        }

        // ================= TOTAL DW COST =================
        $rowIndex++;
        $sheet->setCellValue('A'.$rowIndex, 'Total DW Cost');
        $sheet->getStyle('A'.$rowIndex)->getFont()->setBold(true);

        $colIndex = 2;
        foreach ($dateList as $date) {

            $total = $this->db->table('job_attendances ja')
                ->selectSum('j.fee')
                ->join('jobs j', 'j.id = ja.job_id')
                ->where('j.hotel_id', $hotelId)
                ->where('DATE(ja.created_at)', $date)
                ->get()
                ->getRow()
                ->fee ?? 0;

            $colCost = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex + 1);
            $sheet->setCellValue($colCost.$rowIndex, $total > 0 ? $total : '-');

            $colIndex += 2;
        }

        // ================= DAILY SUMMARY PER TANGGAL =================
        $rowIndex += 2;

        $sheet->setCellValue('A'.$rowIndex, 'Daily Summary');
        $sheet->getStyle('A'.$rowIndex)->getFont()->setBold(true);
        $rowIndex++;

        // Revenue Row
        $sheet->setCellValue('A'.$rowIndex, 'Revenue');
        $colIndex = 2;
        foreach ($dateList as $date) {

            $revenue = $this->db->table('hotel_transactions')
                ->select('amount')
                ->where('hotel_id', $hotelId)
                ->where('type', 'credit')
                ->where('category', 'revenue')
                ->where('date', $date)
                ->get()
                ->getRow()
                ->amount ?? 0;

            $colCost = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex + 1);
            $sheet->setCellValue($colCost.$rowIndex, $revenue > 0 ? $revenue : '-');

            $colIndex += 2;
        }

        $rowIndex++;

        // Ratio Row
        $sheet->setCellValue('A'.$rowIndex, 'Rasio');
        $colIndex = 2;

        foreach ($dateList as $date) {

            $row = $this->db->table('hotel_transactions')
                ->select('dw_ratio, dw_label')
                ->where('hotel_id', $hotelId)
                ->where('type', 'credit')
                ->where('category', 'revenue')
                ->where('date', $date)
                ->get()
                ->getRowArray();

            $ratio = (float)($row['dw_ratio'] ?? 0);
            $label = $row['dw_label'] ?? '-';

            $colDW   = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex);
            $colCost = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex + 1);

            $sheet->setCellValue($colDW.$rowIndex, $ratio > 0 ? $ratio.'%' : '-');
            $sheet->setCellValue($colCost.$rowIndex, $label);

            // ================= WARNA BACKGROUND =================
            $bgColor = 'FFFFFF';

            if ($ratio >= 6 && $ratio <= 10) {
                $bgColor = 'D4EDDA'; // hijau
            } 
            else if ($ratio > 10 && $ratio <= 12) {
                $bgColor = 'FFF3CD'; // kuning
            } 
            else if ($ratio > 12 && $ratio <= 15) {
                $bgColor = 'F8D7DA'; // merah muda
            } 
            else if ($ratio > 15) {
                $bgColor = 'F5C6CB'; // merah
            } 
            else {
                $bgColor = 'D1ECF1'; // biru
            }

            $sheet->getStyle($colCost.$rowIndex)->applyFromArray([
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'startColor' => [
                        'rgb' => $bgColor
                    ]
                ],
                'font' => [
                    'bold' => true
                ],
                'alignment' => [
                    'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER
                ]
            ]);

            $colIndex += 2;
        }

        // ================= MTD PER TANGGAL (AKUMULASI) =================
        $rowIndex += 2;

        $sheet->setCellValue('A'.$rowIndex, 'Month To Date');
        $sheet->getStyle('A'.$rowIndex)->getFont()->setBold(true);
        $rowIndex++;

        // ===== Revenue Row (Akumulasi)
        $sheet->setCellValue('A'.$rowIndex, 'Revenue');

        $colIndex = 2;
        $cumulativeRevenue = 0;
        $cumulativeCost    = 0;

        foreach ($dateList as $date) {

            // revenue harian
            $revenue = $this->db->table('hotel_transactions')
                ->select('amount')
                ->where('hotel_id', $hotelId)
                ->where('type', 'credit')
                ->where('category', 'revenue')
                ->where('date', $date)
                ->get()
                ->getRow()
                ->amount ?? 0;

            $cumulativeRevenue += $revenue;

            $colCost = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex + 1);
            $sheet->setCellValue($colCost.$rowIndex, $cumulativeRevenue > 0 ? $cumulativeRevenue : '-');

            $colIndex += 2;
        }

        $rowIndex++;

        // ===== Rasio Row (Akumulasi Cost / Revenue)
        $sheet->setCellValue('A'.$rowIndex, 'Rasio');

        $colIndex = 2;
        $cumulativeRevenue = 0;
        $cumulativeCost    = 0;

        foreach ($dateList as $date) {

            // revenue harian
            $revenue = $this->db->table('hotel_transactions')
                ->select('amount')
                ->where('hotel_id', $hotelId)
                ->where('type', 'credit')
                ->where('category', 'revenue')
                ->where('date', $date)
                ->get()
                ->getRow()
                ->amount ?? 0;

            // cost harian
            $cost = $this->db->table('job_attendances ja')
                ->selectSum('j.fee')
                ->join('jobs j', 'j.id = ja.job_id')
                ->where('j.hotel_id', $hotelId)
                ->where('DATE(ja.created_at)', $date)
                ->get()
                ->getRow()
                ->fee ?? 0;

            $cumulativeRevenue += $revenue;
            $cumulativeCost    += $cost;

            $ratio = $cumulativeRevenue > 0
                ? round(($cumulativeCost / $cumulativeRevenue) * 100, 2)
                : 0;

            $colDW = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($colIndex);

            $sheet->setCellValue($colDW.$rowIndex, $ratio > 0 ? $ratio.'%' : '-');

            $colIndex += 2;
        }

        $filename = 'Daily_Report_'.date('Ymd_His').'.xlsx';

        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');

        $writer = new \PhpOffice\PhpSpreadsheet\Writer\Xlsx($spreadsheet);
        $writer->save('php://output');
        exit;
    }

    private function getRatioLabel(float $ratio, int $hotelId, ?string $department = null): string
    {
        // =========================
        // 1️⃣ HOTEL + DEPARTMENT
        // =========================
        if ($department !== null) {
            $rule = $this->db->table('ratio_rules')
                ->where('hotel_id', $hotelId)
                ->where('department_category', $department)
                ->where('is_active', 1)
                ->where('min_value <=', $ratio)
                ->where('max_value >', $ratio)
                ->orderBy('sort_order', 'ASC')
                ->get()
                ->getRowArray();

            if ($rule) {
                return $rule['label'];
            }
        }

        // =========================
        // 2️⃣ HOTEL GLOBAL
        // =========================
        $rule = $this->db->table('ratio_rules')
            ->where('hotel_id', $hotelId)
            ->where('department_category', null)
            ->where('is_active', 1)
            ->where('min_value <=', $ratio)
            ->where('max_value >', $ratio)
            ->orderBy('sort_order', 'ASC')
            ->get()
            ->getRowArray();

        if ($rule) {
            return $rule['label'];
        }

        // =========================
        // 3️⃣ GLOBAL DEFAULT
        // =========================
        $rule = $this->db->table('ratio_rules')
            ->where('hotel_id', null)
            ->where('department_category', null)
            ->where('is_active', 1)
            ->where('min_value <=', $ratio)
            ->where('max_value >', $ratio)
            ->orderBy('sort_order', 'ASC')
            ->get()
            ->getRowArray();

        return $rule['label'] ?? 'UNDEFINED';
    }

    public function skillRatio()
    {
        $hotelId = session()->get('hotel_id');
        $attendanceDate = date('Y-m-d', strtotime('-1 day'));
        $start = $attendanceDate . ' 00:00:00';
        $end   = $attendanceDate . ' 23:59:59';
        $daysInMonth = date('t', strtotime($attendanceDate));

        // ==========================
        // Ambil semua skill
        // ==========================
        $skills = $this->db->table('skills')
            ->select('name, category')
            ->orderBy('category', 'ASC')
            ->get()
            ->getResultArray();

        // ==========================
        // Revenue Global
        // ==========================
        $revenueRow = $this->db->table('hotel_transactions')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('date', $attendanceDate)
            ->get()
            ->getRowArray();

        $todayRevenue = (float)($revenueRow['amount'] ?? 0);

        $result = [];

        foreach ($skills as $skill) {

            $skillName = $skill['name'];
            $category  = $skill['category'];

            $rows = $this->db->table('job_attendances ja')
                ->select('
                    j.category as job_category,
                    j.fee,
                    wc.base_salary,
                    COUNT(DISTINCT ja.application_id) as total_applications,
                    COUNT(DISTINCT ja.user_id) as total_workers
                ')
                ->join('jobs j', 'j.id = ja.job_id')
                ->join('worker_contracts wc',
                       'wc.user_id = ja.user_id AND wc.contract_type = "corporate"',
                       'left')
                ->where('j.hotel_id', $hotelId)
                ->where('j.position', $skillName)
                ->where('ja.created_at >=', $start)
                ->where('ja.created_at <=', $end)
                ->groupBy('j.id')
                ->get()
                ->getResultArray();

            $skillCost = 0;

            foreach ($rows as $row) {

                if ($row['job_category'] === 'daily_worker') {

                    $dw = (int)$row['total_applications'];
                    $cost = $dw * (float)$row['fee'];

                } elseif ($row['job_category'] === 'corporate') {

                    $dw = (int)$row['total_workers'];
                    $dailySalary = (float)$row['base_salary'] / $daysInMonth;
                    $cost = $dw * $dailySalary;

                } else {
                    $cost = 0;
                }

                $skillCost += $cost;
            }

            $ratio = $todayRevenue > 0
                ? round(($skillCost / $todayRevenue) * 100, 2)
                : 0;

            $label = $this->getRatioLabel($ratio, $hotelId, $category);

            $result[] = [
                'category'   => $category,
                'skill_name' => $skillName,
                'cost'       => $skillCost,
                'revenue'    => $todayRevenue,
                'ratio'      => $ratio,
                'label'      => $label
            ];
        }

        return $this->response->setJSON([
            'status' => true,
            'date'   => $attendanceDate,
            'data'   => $result
        ]);
    }

    public function skillRatioByDepartment()
    {
        $hotelId = session()->get('hotel_id');
        $department = $this->request->getGet('department');
        $type = $this->request->getGet('type') ?? 'all';

        if (!$department) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Department required'
            ]);
        }

        $attendanceDate = date('Y-m-d', strtotime('-1 day'));
        $start = $attendanceDate . ' 00:00:00';
        $end   = $attendanceDate . ' 23:59:59';
        $daysInMonth = date('t', strtotime($attendanceDate));

        // ==========================
        // Ambil revenue harian (global)
        // ==========================
        $revenueRow = $this->db->table('hotel_transactions')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('date', $attendanceDate)
            ->get()
            ->getRowArray();

        $todayRevenue = (float)($revenueRow['amount'] ?? 0);

        // ==========================
        // Ambil semua skill dalam department
        // ==========================
        $skills = $this->db->table('skills')
            ->select('name')
            ->where('category', $department)
            ->orderBy('name', 'ASC')
            ->get()
            ->getResultArray();

        $result = [];

        foreach ($skills as $skill) {

            $skillName = $skill['name'];

            // ==========================
            // Hitung cost per skill
            // ==========================
            $builder = $this->db->table('job_attendances ja')
                ->select('
                    j.category as job_category,
                    j.fee,
                    wc.base_salary,
                    COUNT(DISTINCT ja.application_id) as total_applications,
                    COUNT(DISTINCT ja.user_id) as total_workers
                ')
                ->join('jobs j', 'j.id = ja.job_id')
                ->join('worker_contracts wc',
                       'wc.user_id = ja.user_id AND wc.contract_type = "corporate"',
                       'left')
                ->where('j.hotel_id', $hotelId)
                ->where('j.position', $skillName)
                ->where('ja.created_at >=', $start)
                ->where('ja.created_at <=', $end);

            if ($type !== 'all') {
                $builder->where('j.category', $type);
            }

            $rows = $builder
                ->groupBy('j.id')
                ->get()
                ->getResultArray();

            $skillCost = 0;

            foreach ($rows as $row) {

                if ($row['job_category'] === 'daily_worker') {

                    $dw = (int)$row['total_applications'];
                    $cost = $dw * (float)$row['fee'];

                } elseif ($row['job_category'] === 'corporate') {

                    $dw = (int)$row['total_workers'];
                    $dailySalary = (float)$row['base_salary'] / $daysInMonth;
                    $cost = $dw * $dailySalary;

                } else {
                    $cost = 0;
                }

                $skillCost += $cost;
            }

            // ==========================
            // Hitung ratio
            // ==========================
            $ratio = $todayRevenue > 0
                ? round(($skillCost / $todayRevenue) * 100, 2)
                : 0;

            $label = $this->getRatioLabel($ratio, $hotelId, '');

            $result[] = [
                'skill_name' => $skillName,
                'cost'       => $skillCost,
                'revenue'    => $todayRevenue,
                'ratio'      => $ratio,
                'label'      => $label
            ];
        }

        return $this->response->setJSON([
            'status' => true,
            'date'   => $attendanceDate,
            'department' => $department,
            'data'   => $result
        ]);
    }

    public function departmentDetail()
    {
        return view('admin/balance/department_detail', [
            'title' => 'Hotel Balance Detail'
        ]);
    }

    public function departmentDetailData()
    {
        $hotelId   = session()->get('hotel_id');
        $department = $this->request->getGet('department');
        $type       = $this->request->getGet('type') ?? 'all';

        if (!$department) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Department required'
            ]);
        }

        // =========================
        // H-1
        // =========================
        $attendanceDate = date('Y-m-d', strtotime('-1 day'));
        $todayStart = $attendanceDate . ' 00:00:00';
        $todayEnd   = $attendanceDate . ' 23:59:59';

        // =========================
        // MTD RANGE (1 → H-1)
        // =========================
        $rangeStart = date('Y-m-01 00:00:00', strtotime($attendanceDate));
        $rangeEnd   = $attendanceDate . ' 23:59:59';

        $daysInMonth = date('t', strtotime($attendanceDate));

        /*
        |--------------------------------------------------------------------------
        | TODAY COST (H-1)
        |--------------------------------------------------------------------------
        */

        $todayRows = $this->db->table('job_attendances ja')
            ->select('
                u.id as user_id,
                j.category as job_category,
                j.fee,
                wc.base_salary,
                COUNT(DISTINCT DATE(ja.created_at)) as total_days
            ')
            ->join('users u', 'u.id = ja.user_id')
            ->join('jobs j', 'j.id = ja.job_id')
            ->join('skills s', 's.name = j.position', 'left')
            ->join(
                'worker_contracts wc',
                'wc.user_id = ja.user_id AND wc.contract_type = "corporate"',
                'left'
            )
            ->where('j.hotel_id', $hotelId)
            ->where('s.category', $department)
            ->where('ja.created_at >=', $todayStart)
            ->where('ja.created_at <=', $todayEnd)
            ->groupBy('u.id')
            ->get()
            ->getResultArray();

        $todayCost = 0;

        foreach ($todayRows as $row) {

            $days = (int)$row['total_days'];

            if ($row['job_category'] === 'daily_worker') {
                $todayCost += $days * (float)$row['fee'];
            }

            if ($row['job_category'] === 'corporate') {
                $dailySalary = (float)$row['base_salary'] / $daysInMonth;
                $todayCost += $days * $dailySalary;
            }
        }

        /*
        |--------------------------------------------------------------------------
        | DETAIL DATA (PER HARI SAJA, BUKAN AKUMULASI)
        |--------------------------------------------------------------------------
        */

        $rows = $this->db->table('job_attendances ja')
            ->select('
                u.id as user_id,
                u.name,
                j.position,
                j.category as job_category,
                j.fee,
                wc.base_salary
            ')
            ->join('users u', 'u.id = ja.user_id')
            ->join('jobs j', 'j.id = ja.job_id')
            ->join('skills s', 's.name = j.position', 'left')
            ->join(
                'worker_contracts wc',
                'wc.user_id = ja.user_id AND wc.contract_type = "corporate"',
                'left'
            )
            ->where('j.hotel_id', $hotelId)
            ->where('s.category', $department)
            ->where('ja.created_at >=', $todayStart)
            ->where('ja.created_at <=', $todayEnd)
            ->groupBy('u.id')
            ->get()
            ->getResultArray();

        $result = [];

        foreach ($rows as $row) {

            $cost = 0;
            $salary = 0;

            if ($row['job_category'] === 'daily_worker') {
                $cost = (float)$row['fee'];
                $salary = (float)$row['fee'];
            }

            if ($row['job_category'] === 'corporate') {
                $dailySalary = (float)$row['base_salary'] / $daysInMonth;
                $cost = $dailySalary;
                $salary = (float)$row['base_salary'];
            }

            $result[] = [
                'name'     => $row['name'],
                'position' => $row['position'],
                'cost'     => round($cost, 2),
                'salary'   => round($salary, 2)
            ];
        }

        /*
        |--------------------------------------------------------------------------
        | MTD COST (AKUMULASI DARI 1 → H-1)
        |--------------------------------------------------------------------------
        */

        $mtdRows = $this->db->table('job_attendances ja')
            ->select('
                j.category as job_category,
                j.fee,
                wc.base_salary,
                COUNT(DISTINCT DATE(ja.created_at)) as total_days
            ')
            ->join('jobs j', 'j.id = ja.job_id')
            ->join('skills s', 's.name = j.position', 'left')
            ->join(
                'worker_contracts wc',
                'wc.user_id = ja.user_id AND wc.contract_type = "corporate"',
                'left'
            )
            ->where('j.hotel_id', $hotelId)
            ->where('s.category', $department)
            ->where('ja.created_at >=', $rangeStart)
            ->where('ja.created_at <=', $rangeEnd)
            ->groupBy('ja.user_id')
            ->get()
            ->getResultArray();

        $mtdCost = 0;

        foreach ($mtdRows as $row) {

            $days = (int)$row['total_days'];

            if ($row['job_category'] === 'daily_worker') {
                $mtdCost += $days * (float)$row['fee'];
            }

            if ($row['job_category'] === 'corporate') {
                $dailySalary = (float)$row['base_salary'] / $daysInMonth;
                $mtdCost += $days * $dailySalary;
            }
        }

        /*
        |--------------------------------------------------------------------------
        | REVENUE
        |--------------------------------------------------------------------------
        */

        $todayRevenue = $this->db->table('hotel_transactions')
            ->selectSum('amount')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('date', $attendanceDate)
            ->get()
            ->getRow()
            ->amount ?? 0;

        $mtdRevenue = $this->db->table('hotel_transactions')
            ->selectSum('amount')
            ->where('hotel_id', $hotelId)
            ->where('type', 'credit')
            ->where('category', 'revenue')
            ->where('date >=', date('Y-m-01', strtotime($attendanceDate)))
            ->where('date <=', $attendanceDate)
            ->get()
            ->getRow()
            ->amount ?? 0;

        /*
        |--------------------------------------------------------------------------
        | RATIO
        |--------------------------------------------------------------------------
        */

        $todayRatio = $todayRevenue > 0
            ? round(($todayCost / $todayRevenue) * 100, 2)
            : 0;

        $mtdRatio = $mtdRevenue > 0
            ? round(($mtdCost / $mtdRevenue) * 100, 2)
            : 0;

        $todayLabel = $this->getRatioLabel($todayRatio, $hotelId, '');
        $mtdLabel   = $this->getRatioLabel($mtdRatio, $hotelId, '');

        return $this->response->setJSON([
            'status'        => true,
            'department'    => $department,
            'date'          => $attendanceDate,
            'data'          => $result,
            'total_cost'    => round($todayCost, 2),
            'mtd_cost'      => round($mtdCost, 2),
            'today_revenue' => (float)$todayRevenue,
            'mtd_revenue'   => (float)$mtdRevenue,
            'today_ratio'   => $todayRatio,
            'mtd_ratio'     => $mtdRatio,
            'today_label'   => $todayLabel,
            'mtd_label'     => $mtdLabel
        ]);
    }
}
