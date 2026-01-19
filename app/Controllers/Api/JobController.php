<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\JobModel;
use App\Models\JobApplicationModel;

class JobController extends BaseController
{
    protected $job;
    protected $apply;

    public function __construct()
    {
        $this->job   = new JobModel();
        $this->apply = new JobApplicationModel();
    }

    /**
     * ============================
     * LIST JOB (OPEN)
     * ============================
     */
    public function index()
    {
        return $this->response->setJSON(
            $this->job
                ->where('status', 'open')
                ->orderBy('job_date', 'ASC')
                ->findAll()
        );
    }

    /**
     * ============================
     * JOB DETAIL
     * ============================
     */
    public function show($id)
    {
        $job = $this->job->find($id);

        if (!$job) {
            return $this->response
                ->setStatusCode(404)
                ->setJSON(['message' => 'Job not found']);
        }

        return $this->response->setJSON($job);
    }

    /**
     * ============================
     * APPLY JOB
     * ============================
     */
    public function apply($jobId)
    {
        $user = $this->request->user;

        // cek job
        $job = $this->job->find($jobId);
        if (!$job || $job['status'] !== 'open') {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Job not available']);
        }

        // cegah apply dobel
        $exists = $this->apply
            ->where('job_id', $jobId)
            ->where('user_id', $user->id)
            ->first();

        if ($exists) {
            return $this->response
                ->setStatusCode(409)
                ->setJSON(['message' => 'Already applied']);
        }

        $this->apply->insert([
            'job_id'    => $jobId,
            'user_id'   => $user->id,
            'status'    => 'pending',
            'applied_at'=> date('Y-m-d H:i:s')
        ]);

        return $this->response->setJSON([
            'message' => 'Apply success'
        ]);
    }
}
