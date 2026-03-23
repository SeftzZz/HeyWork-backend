<?php

namespace App\Controllers\Admin;

use App\Controllers\BaseController;
use Config\Database;

class ScheduleApprovals extends BaseController
{
    protected $db;

    public function __construct()
    {
        $this->db = Database::connect();
    }

    // =========================
    // LIST PENDING
    // =========================
    public function index()
    {
        $hotelId = session()->get('hotel_id');
        $role    = session()->get('user_role');

        $builder = $this->db->table('schedule_plans sp');

        $builder->select('sp.*, u.name as requester_name')
            ->join('users u', 'u.id = sp.requested_by', 'left')
            ->where('sp.hotel_id', $hotelId)
            ->where('sp.status', 'pending')
            ->orderBy('sp.created_at', 'DESC');

        // Jika bukan HR atau admin → filter berdasarkan department
        if (!in_array($role, ['admin','hotel_hr','hotel_gm'])) {
            $department = $this->getDepartmentFromRole($role);
            $builder->join('schedule_days sd', 'sd.schedule_plan_id = sp.id', 'left')
                    ->join('schedule_shifts ss', 'ss.schedule_day_id = sd.id', 'left')
                    ->join('job_applications ja', 'ja.id = ss.application_id', 'left')
                    ->join('jobs j', 'j.id = ja.job_id', 'left')
                    ->join('skills s', 's.name = j.position', 'left')
                    ->where('s.category', $department);
        }

        $plans = $builder->get()->getResult();

        // revisions
        $revisions = $this->db->table('schedule_revisions')
            ->where('status', 'pending')
            ->orderBy('created_at DESC')
            ->get()
            ->getResult();

        return view('admin/schedules/approvals', [
            'title'     => "Schedule Approvals",
            'plans'     => $plans,
            'revisions' => $revisions
        ]);
    }

    // =========================
    // APPROVE PLAN
    // =========================
    public function approvePlan($id)
    {
        $userId = session()->get('user_id');

        $this->db->transBegin();

        // =========================
        // APPROVE PLAN
        // =========================
        $this->db->table('schedule_plans')
            ->where('id', $id)
            ->update([
                'status'      => 'approved',
                'approved_by' => $userId,
                'approved_at' => date('Y-m-d H:i:s')
            ]);

        // =========================
        // GET ALL SHIFTS (REGULAR ONLY)
        // =========================
        $shifts = $this->db->table('schedule_shifts ss')
            ->select('ss.id as shift_id, ss.user_id, d.shift_date')
            ->join('schedule_days d', 'd.id = ss.schedule_day_id')
            ->where('d.schedule_plan_id', $id)
            ->where('ss.shift_type', 'regular')
            ->get()
            ->getResultArray();

        foreach ($shifts as $shift) {
            // =========================
            // FIND JOB + APPLICATION
            // =========================
            $job = $this->db->table('job_applications ja')
                ->select('ja.id as application_id, j.id as job_id')
                ->join('jobs j', 'j.id = ja.job_id')
                ->where('ja.user_id', $shift['user_id'])
                ->where('j.job_date_start <=', $shift['shift_date'])
                ->where('j.job_date_end >=', $shift['shift_date'])
                ->orderBy('j.job_date_start', 'DESC')
                ->get()
                ->getRowArray();

            if ($job) {
                $this->db->table('schedule_shifts')
                    ->where('id', $shift['shift_id'])
                    ->update([
                        'job_id'         => $job['job_id'],
                        'application_id' => $job['application_id']
                    ]);
            }
        }

        if ($this->db->transStatus() === false) {
            $this->db->transRollback();
            return redirect()->back()->with('error','Failed to approve schedule');
        }

        $this->db->transCommit();

        return redirect()->back()->with('success','Schedule approved and shifts linked to jobs');
    }

    public function rejectPlan($id)
    {
        $this->db->table('schedule_plans')
            ->where('id', $id)
            ->update(['status' => 'rejected']);

        return redirect()->back()->with('error','Schedule rejected');
    }

    // =========================
    // APPROVE REVISION
    // =========================
    public function approveRevision($revisionId)
    {
        $userId = session()->get('user_id');

        $revision = $this->db->table('schedule_revisions')
            ->where('id', $revisionId)
            ->get()
            ->getRow();

        if (!$revision) {
            return redirect()->back()->with('error','Revision not found');
        }

        // Apply revision logic here (update schedule_details)

        $this->db->table('schedule_revisions')
            ->where('id', $revisionId)
            ->update([
                'status'      => 'approved',
                'approved_by' => $userId,
                'approved_at' => date('Y-m-d H:i:s')
            ]);

        return redirect()->back()->with('success','Revision approved');
    }

    public function rejectRevision($revisionId)
    {
        $this->db->table('schedule_revisions')
            ->where('id', $revisionId)
            ->update(['status' => 'rejected']);

        return redirect()->back()->with('error','Revision rejected');
    }

    private function getDepartmentFromRole($role)
    {
        $map = [
            'hotel_fo'             => 'Front Office',
            'hotel_hk'             => 'Housekeeping',
            'hotel_fnb_service'    => 'Food & Beverage Service',
            'hotel_fnb_production' => 'Kitchen / Culinary',
            'hotel_fna'            => 'Finance',
            'hotel_eng'            => 'Engineering',
            'hotel_sales'          => 'Sales & Marketing',
            'hotel_gm'             => 'Management'
        ];

        return $map[$role] ?? null;
    }
}