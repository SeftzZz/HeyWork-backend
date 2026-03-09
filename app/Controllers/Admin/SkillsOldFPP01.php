<?php

namespace App\Controllers\Admin;

use App\Models\SkillModel;

class Skills extends BaseAdminController
{
    protected $skillsModel;

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
        $builder = $this->skillModel
            ->where('deleted_at', null);

        // FILTER BERDASARKAN ROLE
        if ($userRole === 'hotel_fo') {
            $builder->where('category', 'Front Office');
        } elseif ($userRole === 'hotel_hk') {
            $builder->where('category', 'Housekeeping');
        } elseif ($userRole === 'hotel_fnb_service') {
            $builder->where('category', 'Food & Beverage Service');
        } elseif ($userRole === 'hotel_fnb_production') {
            $builder->where('category', 'Kitchen / Culinary');
        } elseif ($userRole === 'hotel_fna') {
            $builder->where('category', 'Finance');
        } elseif ($userRole === 'hotel_eng') {
            $builder->where('category', 'Engineering');
        } elseif ($userRole === 'hotel_sales') {
            $builder->where('category', 'Sales & Marketing');
        } elseif ($userRole === 'hotel_sales') {
            $builder->where('category', 'Sales & Marketing');
        }

        // hotel_hr tidak difilter (lihat semua)
        $data = [
            'title'  => 'Skills',
            'skills' => $builder
                ->orderBy('name', 'ASC')
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
        $order  = $request->getPost('order');

        // Mapping kolom untuk sorting
        $orderColumns = [
            0 => null,
            1 => 's.name',
            2 => 'manpower_requests.manpower_needed',
            3 => 'manpower_requests.reason',
            4 => 'manpower_requests.status',
            5 => 'manpower_requests.created_at'
        ];

        $db = \Config\Database::connect();

        /* ================= BASE QUERY ================= */
        $baseBuilder = $db->table('manpower_requests mr')
            ->join('skills s', 's.id = mr.position_id', 'left')
            ->where('mr.deleted_at', null);

        /* ================= FILTER ROLE ================= */
        $userRole = session()->get('user_role');
        $userId   = session()->get('user_id');
        $hotelId  = session()->get('hotel_id');

        $baseBuilder->where('mr.hotel_id', $hotelId);

        /* ================= FILTER CATEGORY BY ROLE ================= */
        $roleCategoryMap = [
            'hotel_fo'             => 'Front Office',
            'hotel_hk'             => 'Housekeeping',
            'hotel_fnb_service'    => 'Food & Beverage Service',
            'hotel_fnb_production' => 'Kitchen / Culinary',
            'hotel_eng'            => 'Engineering',
            'hotel_sales'          => 'Sales & Marketing',
            'hotel_fna'            => 'Finance',
        ];

        if ($userRole !== 'hotel_gm') {
            if (isset($roleCategoryMap[$userRole])) {
                $baseBuilder->where('s.category', $roleCategoryMap[$userRole]);
            }
        }

        if ($userRole === 'hotel_hr') {
            $baseBuilder->where('mr.requested_by', $userId);
        }

        /* ================= SEARCH ================= */
        if (!empty($searchValue)) {
            $searchLower = strtolower($searchValue);

            $baseBuilder->groupStart()
                ->like('s.name', $searchValue)
                ->orLike('mr.reason', $searchValue)
                ->orLike('mr.status', $searchValue);

            // ===== Custom flexible status matching =====
            if (str_contains($searchLower, 'draft')) {
                $baseBuilder->orWhere('mr.status', 'draft');
            }
            if (str_contains($searchLower, 'submitted')) {
                $baseBuilder->orWhere('mr.status', 'submitted');
            }
            if (str_contains($searchLower, 'approved')) {
                $baseBuilder->orWhereIn('mr.status', ['Approved']);
            }
            if (str_contains($searchLower, 'rejected')) {
                $baseBuilder->orWhereIn('mr.status', ['Rejected']);
            }
            if (str_contains($searchLower, 'waiting')) {
                $baseBuilder->orWhere('mr.status', 'Waiting');
            }
            $baseBuilder->groupEnd();
        }

        /* ================= COUNT FILTERED ================= */
        $builderFiltered = clone $baseBuilder;
        $recordsFiltered = $builderFiltered->countAllResults();

        /* ================= COUNT TOTAL ================= */
        $recordsTotal = $db->table('manpower_requests')
            ->where('deleted_at', null)
            ->countAllResults();

        /* ================= GET DATA ================= */
        $builderData = clone $baseBuilder;

        $data = $builderData
            ->select('mr.*, s.name AS position_name')
            ->orderBy('mr.id', 'DESC')
            ->limit($length, $start)
            ->get()
            ->getResultArray();

        // ================= FORMAT DATA =================
        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {
            $statusLabel = match($row['status']) {
                'Draft'             => 'Draft',
                'Submitted'         => 'Submitted',
                'Approved'          => 'Approved',
                'Rejected'          => 'Rejected',
                'Waiting'           => 'Waiting',
                default             => ucfirst($row['status'])
            };

            // Warna badge dinamis
            $badgeClass = match($row['status']) {
                'Approved' => 'bg-label-success',
                'Rejected' => 'bg-label-danger',
                'Submitted' => 'bg-label-warning',
                'Waiting' => 'bg-label-warning',
                default => 'bg-label-primary'
            };

            // Tombol action
            $actionButtons = '';
            if ($row['status'] === 'Draft') {
                $actionButtons = '
                    <button type="button" class="btn btn-icon btn-primary btn-edit" data-id="'.$row['id'].'">
                        <i class="tf-icons ti ti-pencil"></i>
                    </button>

                    <button type="button" class="btn btn-icon btn-danger btn-delete" data-id="'.$row['id'].'">
                        <i class="tf-icons ti ti-trash"></i>
                    </button>

                    <button type="button" class="btn btn-icon btn-success btn-submit" data-id="'.$row['id'].'">
                        <i class="tf-icons ti ti-send"></i>
                    </button>
                ';
            } else {
                $actionButtons = ''; // default kosong (bisa diatur nanti jika perlu)
            }

            // ================= HRM APPROVAL =================
            $hrmApproval = match($row['hrm_approval']) {
                null        => '-',
                'yes'       => 'Ok',
                'no'        => 'No',
                default     => '-'
            };

            // ================= GM APPROVAL =================
            $gmApproval = match($row['gm_approval']) {
                null        => '-',
                'yes'       => 'Ok',
                'no'        => 'No',
                default     => '-'
            };

            $result[] = [
                'no_urut'        => $no++ . '.',
                'position'       => esc($row['position_name'] ?? '-'),
                'mp_needed'      => $row['manpower_needed'] . ' Person',
                'reason'         => '<span 
                                        data-bs-toggle="popover"
                                        data-bs-placement="bottom"
                                        data-bs-content="'.esc($row['reason']).'"
                                    >' 
                                    .esc(mb_substr($row['reason'],0,13)).'...' .
                                    '<i class="ti ti-chevron-down ms-1"></i>'.
                                    '</span>',
                'hrm_approval'   => '<span 
                                        data-bs-toggle="popover"
                                        data-bs-placement="bottom"
                                        data-bs-content="'.esc($row['hrm_note']).'"
                                    >' 
                                    .$hrmApproval.
                                    '<i class="ti ti-chevron-down ms-1"></i>'.
                                    '</span>',
                'gm_approval'    => '<span 
                                        data-bs-toggle="popover"
                                        data-bs-placement="bottom"
                                        data-bs-content="'.esc($row['gm_note']).'"
                                    >' 
                                    .$gmApproval.
                                    '<i class="ti ti-chevron-down ms-1"></i>'.
                                    '</span>',
                'status_mp'      => '<span class="badge '.$badgeClass.'">'.$statusLabel.'</span>',
                'created'        => date('d M Y H:i', strtotime($row['created_at'])),
                'action'         => $actionButtons
            ];
        }

        return $this->response->setJSON([
            'draw'            => (int) $request->getPost('draw'),
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $result
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

        $data = [
            'hotel_id'        => session()->get('hotel_id'),
            'position_id'     => $this->request->getPost('position'),
            'manpower_needed' => $this->request->getPost('tot_worker'),
            'reason'          => $this->request->getPost('reason'),
            'requested_by'    => session()->get('user_id'),
            'status'          => 'draft',
            'created_at'      => date('Y-m-d H:i:s'),
            'created_by'      => session()->get('user_id')
        ];

        $this->manpowerModel->insert($data);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Manpower request added successfully'
        ]);
    }

    // ===============================
    // EDIT
    // ===============================
    public function getById()
    {
        if (!$this->request->isAJAX()) {
            return $this->response->setStatusCode(404);
        }

        $id = $this->request->getPost('id');
        $manpr = $this->manpowerModel->find($id);

        if (!$manpr) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Data tidak ditemukan'
            ]);
        }

        return $this->response->setJSON([
            'status' => true,
            'data'   => $manpr
        ]);
    }

    public function update()
    {
        if (!$this->request->isAJAX()) {
            return $this->response->setStatusCode(404);
        }

        $id = $this->request->getPost('id');
        $manpr = $this->manpowerModel->find($id);

        if (!$manpr) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Data tidak ditemukan'
            ]);
        }

        $data = [
            'position_id'     => $this->request->getPost('position'),
            'manpower_needed' => $this->request->getPost('tot_worker'),
            'reason'          => $this->request->getPost('reason'),
            'updated_at'      => date('Y-m-d H:i:s'),
            'updated_by'      => session()->get('user_id')
        ];

        $this->manpowerModel->update($id, $data);

        return $this->response->setJSON([
            'status' => true,
            'message' => 'Manpower Requests successfully updated'
        ]);
    }

    // ===============================
    // DELETE (SOFT)
    // ===============================
    public function delete()
    {
        $id = $this->request->getPost('id');

        $this->manpowerModel->update($id, [
            'deleted_at' => date('Y-m-d H:i:s'),
            'deleted_by' => session()->get('user_id')
        ]);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Data deleted successfully'
        ]);
    }

    // ===============================
    // SUBMIT APPROVAL
    // ===============================
    public function submit()
    {
        $id = $this->request->getPost('id');

        $this->manpowerModel->update($id, [
            'status' => 'submitted',
            'updated_at' => date('Y-m-d H:i:s'),
            'updated_by' => session()->get('user_id')
        ]);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Data submited successfully'
        ]);
    }
}