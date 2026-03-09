<?php

namespace App\Controllers\Admin;

use App\Controllers\BaseController;
use Config\Database;

class TrainingApprovals extends BaseController
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

        $plans = $this->db->table('training_plans')
            ->where('hotel_id', $hotelId)
            ->where('status', 'pending')
            ->orderBy('created_at DESC')
            ->get()
            ->getResult();

        $revisions = $this->db->table('training_revisions')
            ->where('status', 'pending')
            ->orderBy('created_at DESC')
            ->get()
            ->getResult();

        return view('admin/trainings/approvals', [
            'title'     => "Training Approvals",
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

        $this->db->table('training_plans')
            ->where('id', $id)
            ->update([
                'status'      => 'approved',
                'approved_by' => $userId,
                'approved_at' => date('Y-m-d H:i:s')
            ]);

        return redirect()->back()->with('success','Training approved');
    }

    // =========================
    // REJECT PLAN
    // =========================
    public function rejectPlan($id)
    {
        $this->db->table('training_plans')
            ->where('id', $id)
            ->update([
                'status' => 'rejected'
            ]);

        return redirect()->back()->with('error','Training rejected');
    }

    // =========================
    // APPROVE REVISION
    // =========================
    public function approveRevision($revisionId)
    {
        $userId = session()->get('user_id');

        $revision = $this->db->table('training_revisions')
            ->where('id', $revisionId)
            ->get()
            ->getRow();

        if (!$revision) {
            return redirect()->back()->with('error','Revision not found');
        }

        // =========================
        // APPLY REVISION CHANGES
        // =========================
        $changes = $this->db->table('training_revision_participants')
            ->where('revision_id', $revisionId)
            ->get()
            ->getResultArray();

        foreach ($changes as $change) {

            if ($change['action'] === 'added') {

                $this->db->table('training_participants')->insert([
                    'training_day_id' => $change['training_day_id'],
                    'user_id'         => $change['user_id'],
                    'created_at'      => date('Y-m-d H:i:s')
                ]);

            }

            if ($change['action'] === 'removed') {

                $this->db->table('training_participants')
                    ->where([
                        'training_day_id' => $change['training_day_id'],
                        'user_id'         => $change['user_id']
                    ])
                    ->delete();

            }

        }

        $this->db->table('training_revisions')
            ->where('id', $revisionId)
            ->update([
                'status'      => 'approved',
                'approved_by' => $userId,
                'approved_at' => date('Y-m-d H:i:s')
            ]);

        return redirect()->back()->with('success','Training revision approved');
    }

    // =========================
    // REJECT REVISION
    // =========================
    public function rejectRevision($revisionId)
    {
        $this->db->table('training_revisions')
            ->where('id', $revisionId)
            ->update([
                'status' => 'rejected'
            ]);

        return redirect()->back()->with('error','Training revision rejected');
    }
}