<?php

namespace App\Controllers\Admin;

use App\Models\ManpowerReqModel;
use App\Models\SkillModel;

class Manpoweracc extends BaseAdminController
{
    protected $manpowerModel;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);
        $this->manpowerModel = new ManpowerReqModel();
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
            'title'  => 'Manpower Approval',
            'skills' => $builder
                ->orderBy('name', 'ASC')
                ->findAll()
        ];

        return view('admin/manpower-acc/index', $data);
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
            ->where('status !=', 'draft')
            ->where('mr.deleted_at', null);

        /* ================= FILTER ROLE ================= */
        $userRole = session()->get('user_role');
        $userId   = session()->get('user_id');
        $hotelId  = session()->get('hotel_id');

        $baseBuilder->where('mr.hotel_id', $hotelId);

        /* ================= SEARCH ================= */
        if (!empty($searchValue)) {
            $searchLower = strtolower($searchValue);

            $baseBuilder->groupStart()
                ->like('s.name', $searchValue)
                ->orLike('mr.reason', $searchValue)
                ->orLike('mr.status', $searchValue);

            // ===== Custom flexible status matching =====
            if (str_contains($searchLower, 'submitted')) {
                $baseBuilder->orWhere('mr.status', 'submitted');
            }
            if (str_contains($searchLower, 'hrm')) {
                $baseBuilder->orWhereIn('mr.status', ['approved_manager', 'rejected_manager']);
            }
            if (str_contains($searchLower, 'approved')) {
                $baseBuilder->orWhereIn('mr.status', ['approved_manager', 'approved_gm']);
            }
            if (str_contains($searchLower, 'rejected')) {
                $baseBuilder->orWhereIn('mr.status', ['rejected_manager', 'rejected_gm']);
            }
            if (str_contains($searchLower, 'gm')) {
                $baseBuilder->orWhereIn('mr.status', ['approved_gm', 'rejected_gm']);
            }
            if (str_contains($searchLower, 'completed')) {
                $baseBuilder->orWhere('mr.status', 'completed');
            }
            $baseBuilder->groupEnd();
        }

        /* ================= COUNT FILTERED ================= */
        $builderFiltered = clone $baseBuilder;
        $recordsFiltered = $builderFiltered->countAllResults();

        /* ================= COUNT TOTAL ================= */
        $recordsTotal = $db->table('manpower_requests')
            ->where('hotel_id', $hotelId)
            ->where('status !=', 'draft')
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
            if ($row['status'] === 'Submitted'||$row['status'] === 'Waiting') {
                $actionButtons = '
                    <button type="button" class="btn btn-icon btn-primary btn-approve" data-id="'.$row['id'].'"  data-bs-toggle="tooltip" data-bs-placement="top" data-bs-custom-class="tooltip-primary" title="Approval">
                        <i class="tf-icons ti ti-check"></i>
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
    // APPROVAL
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

    public function acc()
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

        $role        = session()->get('user_role');
        $userId      = session()->get('user_id');
        $persetujuan = $this->request->getPost('persetujuan');
        $catatan     = $this->request->getPost('catatan');

        $data = [
            'updated_at' => date('Y-m-d H:i:s'),
            'updated_by' => $userId
        ];

        if ($role == 'hotel_hr') {
            $data['hrm_id']       = $userId;
            $data['hrm_approval'] = $persetujuan;
            $data['hrm_note']     = $catatan;
        }

        if ($role == 'hotel_gm') {
            $data['gm_id']       = $userId;
            $data['gm_approval'] = $persetujuan;
            $data['gm_note']     = $catatan;
        }

        // Update approval dulu
        $this->manpowerModel->update($id, $data);

        // Ambil ulang data terbaru
        $updated = $this->manpowerModel->find($id);

        $hrm = $updated['hrm_approval'];
        $gm  = $updated['gm_approval'];

        // Tentukan status
        if ($hrm === 'yes' && $gm === 'yes') {
            $status = 'Approved';
        } elseif ($hrm === null || $gm === null) {
            $status = 'Waiting';
        } else {
            $status = 'Rejected';
        }

        // Update status
        $this->manpowerModel->update($id, ['status' => $status]);

        return $this->response->setJSON([
            'status' => true,
            'message' => 'Manpower Requests successfully updated'
        ]);
    }
}