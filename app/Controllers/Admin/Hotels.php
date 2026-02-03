<?php

namespace App\Controllers\Admin;

use App\Models\HotelModel;

class Hotels extends BaseAdminController
{
    protected $hotelModel;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);

        $this->hotelModel = new HotelModel();
    }

    public function index()
    {
        $data = [
            'title'  => 'Hotels'
        ];

        return view('admin/hotels/index', $data);
    }

    // ===============================
    // DATATABLE SERVER SIDE
    // ===============================
    public function datatable()
    {
        $request = service('request');

        $columns = [
            null,
            'id',
            'hotel_name',
            'location',
            'latitude',
            'longitude',
            'website',
            null
        ];

        $builder = $this->hotelModel
            ->where('deleted_at', null);

        // SEARCH
        $search = $request->getPost('search')['value'] ?? null;
        if ($search) {
            $builder->groupStart()
                ->like('hotel_name', $search)
                ->orLike('location', $search)
                ->orLike('website', $search)
            ->groupEnd();
        }

        // ORDER
        $order = $request->getPost('order');
        if ($order) {
            $col = $columns[$order[0]['column']];
            if ($col) {
                $builder->orderBy($col, $order[0]['dir']);
            }
        }

        // COUNT
        $recordsFiltered = (clone $builder)->countAllResults();
        $recordsTotal    = $this->hotelModel->where('deleted_at', null)->countAllResults();

        // PAGINATION
        $length = (int) ($request->getPost('length') ?? 10);
        $start  = (int) ($request->getPost('start') ?? 0);
        $data = $builder->limit($length, $start)->get()->getResultArray();

        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {
            $result[] = [
                'hotel_name' => esc($row['hotel_name']),
                'location'   => esc($row['location']),
                'latitude'   => $row['latitude'],
                'longitude'  => $row['longitude'],
                'website'    => esc($row['website']),
                'action'     => '
                    <button class="btn btn-sm btn-primary btn-edit" data-id="'.$row['id'].'">Edit</button>
                    <button class="btn btn-sm btn-danger btn-delete" data-id="'.$row['id'].'">Delete</button>
                '
            ];
        }


        return $this->response->setJSON([
            'draw' => intval($request->getPost('draw')),
            'recordsTotal' => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data' => $result
        ]);
    }


    // public function datatable()
    // {
    //     $request = service('request');
    //     $db      = db_connect();
    //     $builder = $db->table('hotels');

    //     // -----------------------
    //     // SELECT
    //     // -----------------------
    //     $builder->select('*');

    //     // -----------------------
    //     // SEARCH
    //     // -----------------------
    //     $search = $request->getPost('search')['value'] ?? null;
    //     if ($search) {
    //         $builder->groupStart()
    //             ->like('name', $search)
    //             ->orLike('address', $search)
    //             ->orLike('website', $search)
    //         ->groupEnd();
    //     }

    //     // -----------------------
    //     // ORDER
    //     // -----------------------
    //     $columns = [
    //         null, 
    //         'id',
    //         'name',
    //         'address',
    //         'latitude',
    //         'longitude',
    //         'website',
    //         'founded_year',
    //         'size',
    //         null 
    //     ];

    //     $orderColumnIndex = $request->getPost('order')[0]['column'] ?? 1;
	// 	$orderDir         = $request->getPost('order')[0]['dir'] ?? 'desc';

	// 	if (!empty($columns[$orderColumnIndex])) {
	// 	    $builder->orderBy($columns[$orderColumnIndex], $orderDir);
	// 	}

    //     // -----------------------
    //     // COUNT FILTERED
    //     // -----------------------
    //     $recordsFiltered = $builder->countAllResults(false);

    //     // -----------------------
    //     // PAGINATION
    //     // -----------------------
    //     $length = $request->getPost('length') ?? 10;
    //     $start  = $request->getPost('start') ?? 0;

    //     $builder->limit($length, $start);

    //     $data = $builder->get()->getResultArray();

    //     // -----------------------
    //     // TOTAL RECORDS
    //     // -----------------------
    //     $recordsTotal = $db->table('hotels')->countAllResults();

    //     // -----------------------
    //     // RESPONSE FORMAT DATATABLE
    //     // -----------------------
    //     return $this->response->setJSON([
    //         'draw'            => intval($request->getPost('draw')),
    //         'recordsTotal'    => $recordsTotal,
    //         'recordsFiltered' => $recordsFiltered,
    //         'data'            => $data
    //     ]);
    // }
}
