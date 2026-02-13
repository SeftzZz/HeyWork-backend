<?php

namespace App\Controllers\Admin;

use App\Models\TransactionModel;

class Transactions extends BaseAdminController
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
        $data = [
            'title'  => 'Transactions'
        ];

        return view('admin/transactions/index', $data);
    }

    // ===============================
    // DATATABLE SERVER SIDE
    // ===============================
    public function datatable()
    {
        $request = service('request');

        $searchValue = $request->getPost('search')['value'] ?? null;
        $searchAmount = null;
        if ($searchValue) {
            // hapus titik → 100.000 jadi 100000
            $searchAmount = str_replace('.', '', $searchValue);

            // pastikan numeric
            if (!is_numeric($searchAmount)) {
                $searchAmount = null;
            }
        }
        $length = (int) $request->getPost('length');
        $start  = (int) $request->getPost('start');

        $order = $request->getPost('order');
        $orderColumns = [
            null,
            null,
            'hotels.hotel_name',
            'hotel_transactions.type',
            'hotel_transactions.amount',
            'hotel_transactions.description',
            'hotel_transactions.created_at',
            null
        ];

        // =============================
        // ROLE & SESSION
        // =============================
        $userRole = session()->get('user_role');
        $hotelId  = session()->get('hotel_id');

        /**
         * Helper filter hotel by role
         */
        $applyHistoryFilter = function ($builder) use ($userRole, $hotelId) {
            $builder->select('hotel_transactions.*, hotels.hotel_name')
                    ->join('hotels', 'hotels.id = hotel_transactions.hotel_id', 'left')
                    ->where('hotel_transactions.deleted_at', null);
            if ($userRole === 'hotel_hr') {
                $builder->where('hotel_transactions.hotel_id', $hotelId);
            }

            return $builder;
        };

        // =============================
        // QUERY FILTERED (COUNT)
        // =============================
        $countQuery = $applyHistoryFilter($this->transactionModel);

        if ($searchValue) {
            $countQuery->groupStart()
                ->like('hotels.hotel_name', $searchValue)
                ->orLike('hotel_transactions.type', $searchValue)
                ->orLike('hotel_transactions.description', $searchValue)
                ->orWhere("DATE_FORMAT(hotel_transactions.created_at, '%d-%m-%Y') LIKE", "%{$searchValue}%");

            // search amount numeric
            if ($searchAmount !== null) {
                $countQuery->orLike('hotel_transactions.amount', $searchAmount);
            }

            $countQuery->groupEnd();
        }

        $recordsFiltered = $countQuery->countAllResults();

        // =============================
        // QUERY TOTAL
        // =============================
        $totalQuery = $applyHistoryFilter($this->transactionModel);
        $recordsTotal = $totalQuery->countAllResults();

        // =============================
        // QUERY DATA
        // =============================
        $dataQuery = $applyHistoryFilter($this->transactionModel);

        if ($searchValue) {
            $dataQuery->groupStart()
                ->like('hotels.hotel_name', $searchValue)
                ->orLike('hotel_transactions.type', $searchValue)
                ->orLike('hotel_transactions.description', $searchValue)
                ->orWhere("DATE_FORMAT(hotel_transactions.created_at, '%d-%m-%Y') LIKE", "%{$searchValue}%");

            if ($searchAmount !== null) {
                $dataQuery->orLike('hotel_transactions.amount', $searchAmount);
            }

            $dataQuery->groupEnd();
        }

        if ($order) {
            $idx = (int) $order[0]['column'];
            if (!empty($orderColumns[$idx])) {
                $dataQuery->orderBy($orderColumns[$idx], $order[0]['dir']);
            }
        }

        $data = $dataQuery
            ->limit($length, $start)
            ->get()
            ->getResultArray();

        // =============================
        // FORMAT DATA
        // =============================
        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {
            $credit = '';
            $debit  = '';
            if ($row['type'] === 'credit') {
                $credit = 'Credit';
            }
            if ($row['type'] === 'debit') {
                $debit = 'Debit';
            }

            $result[] = [
                'no_urut'   => $no++ . '.',
                'namahotel' => esc($row['hotel_name']),
                'tgl'       => date('d-m-Y', strtotime($row['created_at'])),
                'kredit'    => $credit,
                'debit'     => $debit,
                'jml'       => number_format($row['amount'], 0, ',', '.'),
                'ket'       => esc($row['description'])
            ];
        }

        return $this->response->setJSON([
            'draw'            => (int) $request->getPost('draw'),
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $result
        ]);
    }
}
