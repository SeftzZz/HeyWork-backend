<?php

namespace App\Controllers\Admin;

use App\Models\SkillModel;

class Skills extends BaseAdminController
{
    protected $skillModel;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);
        $this->skillModel = new SkillModel();
    }

    public function index()
    {
        $userRole = session()->get('user_role');
        $hotelId  = session()->get('hotel_id');

        $data = [
            'title' => 'Skills',
            'categories' => $this->skillModel
                ->select('category AS name')
                ->where('deleted_at', null)
                ->where('hotel_id', $hotelId)
                ->groupBy('category')
                ->orderBy('category','ASC')
                ->findAll()
        ];

        return view('admin/skills/index', $data);
    }

    // ===============================
    // DATATABLE SERVER SIDE
    // ===============================
    public function datatable()
    {
        $request = service('request');

        $searchValue = $request->getPost('search')['value'] ?? null;
        $length = (int) $request->getPost('length');
        $start  = (int) $request->getPost('start');

        $userRole = session()->get('user_role');
        $hotelId  = session()->get('hotel_id');

        $builder = $this->skillModel
            ->where('deleted_at', null)
            ->where('hotel_id', $hotelId);

        if ($searchValue) {
            $builder->groupStart()
                ->like('name', $searchValue)
                ->orLike('category', $searchValue)
            ->groupEnd();
        }

        $recordsFiltered = $builder->countAllResults(false);

        $data = $builder
            ->orderBy('name', 'ASC')
            ->limit($length, $start)
            ->find();

        $recordsTotal = $this->skillModel
            ->where('deleted_at', null)
            ->countAllResults();

        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {
            $action = '
                <button class="btn btn-icon btn-primary btn-edit" data-id="'.$row['id'].'" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="tooltip-primary" title="Edit">
                    <i class="ti ti-pencil"></i>
                </button>

                <button class="btn btn-icon btn-danger btn-delete" data-id="'.$row['id'].'" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="tooltip-danger" title="Delete">
                    <i class="ti ti-trash"></i>
                </button>
            ';

            $result[] = [
                'no_urut' => $no++ . '.',
                'name' => esc($row['name']),
                'category' => esc($row['category']),
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

    // ===============================
    // STORE
    // ===============================
    public function store()
    {
        if (!$this->request->isAJAX()) {
            return $this->response->setStatusCode(404);
        }

        $name = trim($this->request->getPost('namaskill'));

        $categorySelect = $this->request->getPost('kategori');
        $categoryManual = $this->request->getPost('kategori_manual');

        if ($categorySelect === '__new__') {
            $category = trim($categoryManual);
        } else {
            $category = trim($categorySelect);
        }

        $hotelId  = session()->get('hotel_id');

        // cek apakah name sudah ada
        $exist = $this->skillModel
            ->where('name', $name)
            ->where('hotel_id', $hotelId)
            ->where('deleted_at', null)
            ->first();

        if ($exist) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Skill name already exists'
            ]);
        }

        $data = [
            'hotel_id'   => $hotelId,
            'name'       => $name,
            'category'   => $category,
            'created_by' => session()->get('user_id')
        ];

        $this->skillModel->insert($data);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Skill successfully added'
        ]);
    }

    // ===============================
    // GET BY ID
    // ===============================
    public function getById()
    {
        $id = $this->request->getPost('id');
        $skill = $this->skillModel
            ->where('deleted_at', null)
            ->find($id);

        if (!$skill) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Data not found'
            ]);
        }

        return $this->response->setJSON([
            'status' => true,
            'data' => $skill
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
        $name     = trim($this->request->getPost('namaskill'));
        $category = $this->request->getPost('kategori');

        $skill = $this->skillModel->find($id);

        if (!$skill) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Data not found'
            ]);
        }

        // CEK DIPAKAI DI TABEL JOBS
        $db = \Config\Database::connect();

        $jobUsed = $db->table('jobs')
            ->where('position', $skill['name'])
            ->countAllResults();

        if ($jobUsed > 0) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Skill cannot be edited because it is already used in Jobs'
            ]);
        }

        // CEK DUPLIKAT NAME
        $duplicate = $this->skillModel
            ->where('LOWER(name)', strtolower($name))
            ->where('id !=', $id)
            ->where('deleted_at', null)
            ->first();

        if ($duplicate) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Skill name already exists'
            ]);
        }

        // UPDATE DATA
        $data = [
            'name'       => $name,
            'category'   => $category,
            'updated_by' => session()->get('user_id')
        ];

        $this->skillModel->update($id, $data);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Skill successfully updated'
        ]);
    }

    // ===============================
    // DELETE (SOFT DELETE)
    // ===============================
    public function delete()
    {
        $id = $this->request->getPost('id');

        // ambil data skill
        $skill = $this->skillModel->find($id);

        if (!$skill) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Skill tidak ditemukan'
            ]);
        }

        // cek apakah skill dipakai di tabel jobs
        $jobModel = new \App\Models\JobModel();

        $used = $jobModel
            ->where('position', $skill['name']) // sesuaikan dengan nama kolom di tabel jobs
            ->countAllResults();

        if ($used > 0) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Skill cannot be deleted because it is already used in Jobs'
            ]);
        }

        // lakukan soft delete
        $this->skillModel->update($id, [
            'deleted_at' => date('Y-m-d H:i:s'),
            'deleted_by' => session()->get('user_id')
        ]);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Skill deleted successfully'
        ]);
    }
}