<?php

namespace App\Controllers\Admin;

use App\Controllers\BaseController;
use Config\Database;

class Trainings extends BaseController
{
    protected $db;

    public function __construct()
    {
        $this->db = Database::connect();
    }

    public function index()
    {
        $hotelId = session()->get('hotel_id');
        $role    = session()->get('user_role');

        // ===============================
        // WORKERS (training participants)
        // ===============================

        $builder = $this->db->table('users u')
            ->distinct()
            ->select('u.id, u.name')
            ->where('u.hotel_id', $hotelId)
            ->where('u.role', 'worker')
            ->where('u.is_active', 1);

        if (!in_array($role, ['admin','hotel_hr'])) {

            $department = $this->getDepartmentFromRole($role);

            $builder->join('job_attendances ja', 'ja.user_id = u.id', 'left')
                    ->join('jobs j', 'j.id = ja.job_id', 'left')
                    ->join('skills s', 's.name = j.position', 'left')
                    ->where('s.category', $department);
        }

        $workers = $builder
            ->groupBy('u.id')
            ->orderBy('u.name', 'ASC')
            ->get()
            ->getResultArray();


        // ===============================
        // TRAINERS
        // ===============================

        $trainerBuilder = $this->db->table('users u')
            ->select('u.id, u.name')
            ->where('u.hotel_id', $hotelId)
            ->where('u.is_active', 1);

        if (!in_array($role, ['admin','hotel_hr'])) {

            $department = $this->getDepartmentFromRole($role);

            $trainerBuilder->join('job_attendances ja', 'ja.user_id = u.id', 'left')
                    ->join('jobs j', 'j.id = ja.job_id', 'left')
                    ->join('skills s', 's.name = j.position', 'left')
                    ->where('s.category', $department);
        }

        $trainers = $trainerBuilder
            ->groupBy('u.id')
            ->orderBy('u.name','ASC')
            ->get()
            ->getResultArray();

        return view('admin/trainings/index', [
            'title'    => 'Trainings',
            'workers'  => $workers,
            'trainers' => $trainers
        ]);
    }

    public function datatable()
    {
        $request = service('request');

        $searchValue = $request->getPost('search')['value'] ?? null;
        $length      = (int) $request->getPost('length');
        $start       = (int) $request->getPost('start');

        $hotelId  = session()->get('hotel_id');
        $userRole = session()->get('user_role');

        $builder = $this->db->table('training_plans')
            ->select('training_plans.*, users.name as requester_name')
            ->join('users','users.id = training_plans.requested_by','left')
            ->where('training_plans.hotel_id', $hotelId);

        // filter department jika bukan admin/hr
        if (!in_array($userRole, ['admin','hotel_hr'])) {
            $department = $this->getDepartmentFromRole($userRole);
            $builder->where('training_plans.department', $department);
        }

        // SEARCH
        if (!empty($searchValue)) {
            $builder->groupStart()
                ->like('training_plans.title', $searchValue)
                ->orLike('training_plans.department', $searchValue)
                ->orLike('training_plans.status', $searchValue)
            ->groupEnd();
        }

        $recordsFiltered = $builder->countAllResults(false);

        $data = $builder
            ->limit($length, $start)
            ->orderBy('training_plans.year','DESC')
            ->orderBy('training_plans.month','DESC')
            ->get()
            ->getResultArray();

        $recordsTotal = $this->db->table('training_plans')
            ->where('hotel_id',$hotelId)
            ->countAllResults();

        $result = [];
        $no = $start + 1;

        foreach ($data as $row) {

            // badge status
            $badge = match ($row['status']) {
                'pending'  => '<span class="badge bg-label-warning">Pending</span>',
                'approved' => '<span class="badge bg-label-success">Approved</span>',
                'rejected' => '<span class="badge bg-label-danger">Rejected</span>',
                'draft'    => '<span class="badge bg-label-secondary">Draft</span>',
                'revised'  => '<span class="badge bg-label-info">Revised</span>',
                default    => '<span class="badge bg-label-dark">'.ucfirst($row['status']).'</span>',
            };

            // convert month number → month name
            $monthName = date('F', mktime(0,0,0,$row['month'],1));

            $action = '
                <div class="d-flex gap-2">
                    <a href="javascript:void(0)"
                       class="btn btn-sm btn-icon btn-primary btn-view"
                       data-id="'.$row['id'].'">
                       <i class="ti ti-eye"></i>
                    </a>
                </div>
            ';

            $result[] = [
                'no'         => $no++,
                'title'      => esc($row['title']),
                'department' => esc($row['department']),
                'month'      => $monthName,
                'year'       => esc($row['year']),
                'status'     => $badge,
                'requester'  => esc($row['requester_name']),
                'created_at' => date('d M Y H:i', strtotime($row['created_at'])),
                'action'     => $action
            ];
        }

        return $this->response->setJSON([
            'draw'            => (int) $request->getPost('draw'),
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $result
        ]);
    }

    public function store()
    {
        $hotelId = session()->get('hotel_id');
        $userId  = session()->get('user_id');
        $userRole = session()->get('user_role');

        $title       = trim($this->request->getPost('title'));
        $department  = trim($this->request->getPost('department'));
        $description = trim($this->request->getPost('description'));
        $month       = (int)$this->request->getPost('month');
        $year        = (int)$this->request->getPost('year');
        $trainerId   = $this->request->getPost('trainer_id');

        // department auto dari role
        if (!in_array($userRole, ['admin','hotel_hr'])) {
            $department = $this->getDepartmentFromRole($userRole);
        }

        if (!$title) {
            return $this->response->setJSON([
                'status'=>false,
                'message'=>'Training title required'
            ]);
        }

        if (!$month || !$year) {
            return $this->response->setJSON([
                'status'=>false,
                'message'=>'Month and year required'
            ]);
        }

        $this->db->transBegin();

        $planData = [
            'hotel_id'     => $hotelId,
            'department'   => $department,
            'title'        => $title,
            'description'  => $description,
            'trainer_id'   => $trainerId ?: null,
            'month'        => $month,
            'year'         => $year,
            'status'       => 'pending',
            'requested_by' => $userId,
            'created_at'   => date('Y-m-d H:i:s')
        ];

        $this->db->table('training_plans')->insert($planData);

        $planId = $this->db->insertID();

        if (!$planId) {
            $this->db->transRollback();
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Failed to create schedule plan'
            ]);
        }

        // ===============================
        // AUTO GENERATE training_days
        // ===============================
        $daysInMonth = (int) date('t', strtotime($year . '-' . $month . '-01'));

        $dayBatch = [];

        for ($d = 1; $d <= $daysInMonth; $d++) {

            $date = $year . '-' .
                    str_pad($month, 2, '0', STR_PAD_LEFT) . '-' .
                    str_pad($d, 2, '0', STR_PAD_LEFT);

            $dayBatch[] = [
                'training_plan_id' => $planId,
                'training_date'    => $date,
                'created_at'       => date('Y-m-d H:i:s')
            ];
        }

        $this->db->table('training_days')->insertBatch($dayBatch);

        if ($this->db->transStatus() === false) {
            $this->db->transRollback();
            return $this->response->setJSON([
                'status'=>false,
                'message'=>'Failed to create training'
            ]);
        }

        $this->db->transCommit();

        return $this->response->setJSON([
            'status'=>true,
            'message'=>'Training created successfully'
        ]);
    }

    public function getDetail()
    {
        $id = $this->request->getPost('id');

        // ===============================
        // GET PLAN
        // ===============================
        $plan = $this->db->table('training_plans')
            ->where('id', $id)
            ->get()
            ->getRowArray();

        if (!$plan) {
            return $this->response->setJSON([
                'status' => false
            ]);
        }

        // ===============================
        // GET DAYS + SHIFTS
        // ===============================
        $rows = $this->db->table('training_days d')
            ->select('
                d.training_date,
                s.user_id,
                s.start_time,
                s.end_time,
                s.shift_type,
                u.name as worker_name
            ')
            ->join('training_shifts s', 's.training_day_id = d.id', 'left')
            ->join('users u', 'u.id = s.user_id', 'left')
            ->where('d.training_plan_id', $id)
            ->orderBy('d.training_date', 'ASC')
            ->get()
            ->getResultArray();

        // ===============================
        // FORMAT BY DATE (GROUPING)
        // ===============================
        $grouped = [];

        foreach ($rows as $row) {

            $date = $row['training_date'];

            if (!isset($grouped[$date])) {
                $grouped[$date] = [
                    'training_date' => $date,
                    'shifts' => []
                ];
            }

            if ($row['user_id']) {
                $grouped[$date]['shifts'][] = [
                    'user_id'     => $row['user_id'],
                    'worker_name' => $row['worker_name'],
                    'start_time'  => $row['start_time'],
                    'end_time'    => $row['end_time'],
                    'shift_type'  => $row['shift_type']
                ];
            }
        }

        $details = array_values($grouped);

        // ===============================
        // STATUS BADGE
        // ===============================
        $badge = match ($plan['status']) {
            'pending'  => '<span class="badge bg-label-warning">Pending</span>',
            'approved' => '<span class="badge bg-label-success">Approved</span>',
            'rejected' => '<span class="badge bg-label-danger">Rejected</span>',
            'revised'  => '<span class="badge bg-label-info">Revised</span>',
            default    => '<span class="badge bg-label-secondary">'.ucfirst($plan['status']).'</span>',
        };

        return $this->response->setJSON([
            'status' => true,
            'data' => [
                'title'        => $plan['title'],
                'department'   => $plan['department'],
                'month_name'   => date('F', mktime(0,0,0,$plan['month'],1)),
                'year'         => $plan['year'],
                'status_badge' => $badge
            ],
            'details' => $details
        ]);
    }

    public function assignParticipant()
    {
        $dayId  = $this->request->getPost('training_day_id');
        $userId = $this->request->getPost('user_id');

        if(!$dayId || !$userId){
            return $this->response->setJSON([
                'status'=>false,
                'message'=>'Invalid data'
            ]);
        }

        $exists = $this->db->table('training_participants')
            ->where([
                'training_day_id'=>$dayId,
                'user_id'=>$userId
            ])
            ->countAllResults();

        if($exists){
            return $this->response->setJSON([
                'status'=>false,
                'message'=>'Worker already assigned'
            ]);
        }

        $this->db->table('training_participants')->insert([
            'training_day_id'=>$dayId,
            'user_id'=>$userId,
            'created_at'=>date('Y-m-d H:i:s')
        ]);

        return $this->response->setJSON([
            'status'=>true,
            'message'=>'Participant assigned'
        ]);
    }

    private function getDepartmentFromRole($role)
    {
        $map = [
            'hotel_fo'             => 'Front Office',
            'hotel_hk'             => 'Housekeeping',
            'hotel_fnb_service'    => 'Food & Beverage Service',
            'hotel_fnb_production' => 'Kitchen / Culinary'
        ];

        return $map[$role] ?? null;
    }
}