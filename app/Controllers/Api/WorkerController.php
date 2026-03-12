<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\UserModel;
use App\Models\WorkerProfileModel;
use App\Models\SkillModel;
use App\Models\WorkerSkillModel;
use App\Models\WorkerExperienceModel;
use App\Models\WorkerDocumentModel;
use App\Models\JobModel;
use App\Models\JobApplicationModel;
use App\Models\JobAttendanceModel;
use App\Models\EducationModel;

class WorkerController extends BaseController
{
    protected $user;
    protected $profile;
    protected $skill;
    protected $workerSkill;
    protected $experience;
    protected $job;
    protected $apply;
    protected $attendance;
    protected $education;

    public function __construct()
    {
        $this->user        = new UserModel();
        $this->profile     = new WorkerProfileModel();
        $this->skill       = new SkillModel();
        $this->workerSkill = new WorkerSkillModel();
        $this->experience  = new WorkerExperienceModel();
        $this->job         = new JobModel();
        $this->apply       = new JobApplicationModel();
        $this->attendance  = new JobAttendanceModel();
        $this->education   = new EducationModel();
    }

    /**
     * ============================
     * GET PROFILE WORKER
     * ============================
     * GET /api/worker/profile
     */
    public function profile()
    {
        // user dari JWT
        $jwtUser = $this->request->user;

        // Optional: validasi role
        if ($jwtUser->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        // Ambil data user dari DB
        $user = $this->user->find($jwtUser->id);

        if (!$user) {
            return $this->response
                ->setStatusCode(404)
                ->setJSON(['message' => 'User not found']);
        }

        unset($user['password']); // keamanan

        return $this->response->setJSON([
            'user' => $user
        ]);
    }

    /**
     * ============================
     * UPDATE PROFILE WORKER
     * ============================
     * PUT /api/worker/profile
     */
    public function updateProfile()
    {
        $jwtUser = $this->request->user;

        if ($jwtUser->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        $data = $this->request->getJSON(true);

        // Field yang boleh diupdate
        $allowed = [
            'name',
            'phone',
            'photo'
        ];

        $updateData = array_intersect_key(
            $data,
            array_flip($allowed)
        );

        if (empty($updateData)) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'No data to update']);
        }

        $this->user->update($jwtUser->id, $updateData);

        return $this->response->setJSON([
            'message' => 'Profile updated successfully'
        ]);
    }

    /**
     * ============================
     * CONTOH ENDPOINT TEST JWT
     * ============================
     * GET /api/worker/me
     */
    public function me()
    {
        return $this->response->setJSON([
            'id'    => $this->request->user->id,
            'email' => $this->request->user->email,
            'role'  => $this->request->user->role
        ]);
    }

    /**
     * ============================
     * LIST MASTER SKILL
     * ============================
     */
    public function skills()
    {
        return $this->response->setJSON([
            'data' => $this->skill
                ->orderBy('name', 'ASC')
                ->findAll()
        ]);
    }

    /**
     * ============================
     * LIST WORKER SKILL
     * ============================
     */
    public function mySkills()
    {
        $user = $this->request->user;

        if ($user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        $skills = $this->workerSkill
            ->select('skills.id, skills.name')
            ->join('skills', 'skills.id = worker_skills.skill_id')
            ->where('worker_skills.user_id', $user->id)
            ->findAll();

        return $this->response->setJSON([
            'data' => $skills
        ]);
    }

    /**
     * ============================
     * SET WORKER SKILLS
     * ============================
     */
    public function setSkills()
    {
        $user = $this->request->user;
        $data = $this->request->getJSON(true);

        if ($user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        if (!isset($data['skill_ids']) || !is_array($data['skill_ids'])) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'skill_ids must be an array']);
        }

        // hapus skill lama
        $this->workerSkill
            ->where('user_id', $user->id)
            ->delete();

        // insert skill baru
        foreach ($data['skill_ids'] as $skillId) {
            $this->workerSkill->insert([
                'user_id'  => $user->id,
                'skill_id' => $skillId,
                'created_by' => $user->id
            ]);
        }

        return $this->response->setJSON([
            'message' => 'Skills updated successfully'
        ]);
    }

    /**
     * ============================
     * ADD EXPERIENCE
     * ============================
     */
    public function addExperience()
    {
        $user = $this->request->user;
        $data = $this->request->getJSON(true);

        // =========================
        // VALIDASI MINIMAL
        // =========================
        if (empty($data['company_name'])) {
            return $this->response->setStatusCode(422)->setJSON([
                'message' => 'Company name is required'
            ]);
        }

        if (empty($data['start_date'])) {
            return $this->response->setStatusCode(422)->setJSON([
                'message' => 'Start date is required'
            ]);
        }

        // =========================
        // NORMALISASI DATA
        // =========================
        $data['user_id']    = $user->id;
        $data['created_by'] = $user->id;
        $data['is_current'] = !empty($data['is_current']) ? 1 : 0;

        if ($data['is_current'] == 1) {
            $data['end_date'] = null;
        }

        // =========================
        // INSERT
        // =========================
        $id = $this->experience->insert($data);

        if (!$id) {
            return $this->response->setStatusCode(500)->setJSON([
                'message' => 'Failed to add experience'
            ]);
        }

        return $this->response->setJSON([
            'message' => 'Experience added',
            'id'      => $id
        ]);
    }

    /**
     * ============================
     * LIST EXPERIENCE
     * ============================
     */
    public function experiences()
    {
        $user = $this->request->user;

        // 1️⃣ CARI EXPERIENCE YANG SEDANG AKTIF
        $current = $this->experience
            ->where('user_id', $user->id)
            ->where('deleted_at', null)
            ->where('is_current', 1)
            ->orderBy('start_date', 'DESC')
            ->first();

        if ($current) {
            return $this->response->setJSON([$current]);
        }

        // 2️⃣ JIKA TIDAK ADA, AMBIL end_date TERDEKAT
        $ended = $this->experience
            ->where('user_id', $user->id)
            ->where('deleted_at', null)
            ->where('end_date IS NOT NULL', null, false)
            ->orderBy('end_date', 'DESC')
            ->first();

        if ($ended) {
            return $this->response->setJSON([$ended]);
        }

        // 3️⃣ FALLBACK: start_date TERDEKAT
        $fallback = $this->experience
            ->where('user_id', $user->id)
            ->where('deleted_at', null)
            ->orderBy('start_date', 'DESC')
            ->first();

        return $this->response->setJSON(
            $fallback ? [$fallback] : []
        );
    }

    /**
     * ============================
     * ADD EDUCATION
     * ============================
     */
    public function addEducation()
    {
        $user = $this->request->user;
        $data = $this->request->getJSON(true);

        // =========================
        // VALIDASI MINIMAL
        // =========================
        if (empty($data['instituted_name'])) {
            return $this->response->setStatusCode(422)->setJSON([
                'message' => 'Instituted name is required'
            ]);
        }

        if (empty($data['start_date'])) {
            return $this->response->setStatusCode(422)->setJSON([
                'message' => 'Start date is required'
            ]);
        }

        // =========================
        // NORMALISASI DATA
        // =========================
        $data['user_id']    = $user->id;
        $data['created_by'] = $user->id;
        $data['is_current'] = !empty($data['is_current']) ? 1 : 0;

        if ($data['is_current'] == 1) {
            $data['end_date'] = null;
        }

        // =========================
        // INSERT
        // =========================
        $id = $this->education->insert($data);

        if (!$id) {
            return $this->response->setStatusCode(500)->setJSON([
                'message' => 'Failed to add education'
            ]);
        }

        return $this->response->setJSON([
            'message' => 'education added',
            'id'      => $id
        ]);
    }

    /**
     * ============================
     * LIST EDUCATION
     * ============================
     */
    public function educations()
    {
        $user = $this->request->user;

        // 1️⃣ PRIORITAS: pendidikan yang sedang berjalan
        $current = $this->education
            ->where('user_id', $user->id)
            ->where('deleted_at', null)
            ->where('is_current', 1)
            ->orderBy('start_date', 'DESC')
            ->first();

        if ($current) {
            return $this->response->setJSON([$current]);
        }

        // 2️⃣ JIKA TIDAK ADA, AMBIL end_date TERDEKAT
        $ended = $this->education
            ->where('user_id', $user->id)
            ->where('deleted_at', null)
            ->where('end_date IS NOT NULL', null, false)
            ->orderBy('end_date', 'DESC')
            ->first();

        if ($ended) {
            return $this->response->setJSON([$ended]);
        }

        // 3️⃣ FALLBACK: start_date TERDEKAT
        $fallback = $this->education
            ->where('user_id', $user->id)
            ->where('deleted_at', null)
            ->orderBy('start_date', 'DESC')
            ->first();

        return $this->response->setJSON(
            $fallback ? [$fallback] : []
        );
    }

    public function uploadPhoto()
    {
        $user = $this->request->user;
        $file = $this->request->getFile('photo');

        if (!$file || !$file->isValid()) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Invalid file']);
        }

        if (!in_array($file->getMimeType(), ['image/jpeg', 'image/png'])) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Only JPG or PNG allowed']);
        }

        if ($file->getSize() > 2 * 1024 * 1024) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Max file size 2MB']);
        }

        $uploadPath = FCPATH . 'uploads/profiles';

        if (!is_dir($uploadPath)) {
            mkdir($uploadPath, 0755, true);
        }

        $newName = 'profile_' . $user->id . '_' . time() . '.' . $file->getExtension();
        $file->move($uploadPath, $newName);

        $publicPath = 'uploads/profiles/' . $newName;

        $this->user->update($user->id, [
            'photo' => $publicPath
        ]);

        return $this->response->setJSON([
            'message' => 'Photo uploaded',
            'photo'   => $publicPath
        ]);
    }

    public function uploadDocument()
    {
        $user = $this->request->user;
        $file = $this->request->getFile('file');
        $type = $this->request->getPost('type'); // ktp / certificate / other

        if (!$file || !$file->isValid()) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Invalid file']);
        }

        $allowed = ['image/jpeg', 'image/png', 'application/pdf'];
        if (!in_array($file->getMimeType(), $allowed)) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Invalid file type']);
        }

        if ($file->getSize() > 10 * 1024 * 1024) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Max file size 5MB']);
        }

        // =========================
        // PATH SESUAI uploadPhoto
        // =========================
        $uploadPath = FCPATH . 'uploads/documents';

        if (!is_dir($uploadPath)) {
            mkdir($uploadPath, 0755, true);
        }

        $newName = 'doc_' . $user->id . '_' . time() . '.' . $file->getExtension();
        $file->move($uploadPath, $newName);

        $publicPath = 'uploads/documents/' . $newName;

        $docModel = new WorkerDocumentModel();
        $docModel->insert([
            'user_id'   => $user->id,
            'type'      => $type ?? 'other',
            'file_path' => $publicPath
        ]);

        return $this->response->setJSON([
            'message'   => 'Document uploaded',
            'file_path' => $publicPath
        ]);
    }

    public function documents()
    {
        $user = $this->request->user;

        $docModel = new WorkerDocumentModel();

        return $this->response->setJSON(
            $docModel->where('user_id', $user->id)->findAll()
        );
    }

    public function applicationList()
    {
        $user = $this->request->user;

        if (!$user || $user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        $model = new JobApplicationModel();

        $data = $model
            ->select(
                'job_applications.id as application_id,
                 job_applications.status,
                 job_applications.applied_at,
                 jobs.id as job_id,
                 jobs.position,
                 jobs.fee,
                 jobs.location,
                 jobs.hotel_id'
            )
            ->join('jobs', 'jobs.id = job_applications.job_id')
            ->where('job_applications.user_id', $user->id)
            ->orderBy('job_applications.applied_at', 'DESC')
            ->findAll();

        return $this->response->setJSON($data);
    }

    public function applications()
    {
        $user = $this->request->user;

        if (!$user || $user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        $rows = $this->apply->workerHistory($user->id) ?? [];

        $counts = [
            'pending'   => 0,
            'accepted'  => 0,
            'completed' => 0,
            'rejected'  => 0
        ];

        foreach ($rows as $row) {

            // pastikan hanya pakai 1 field konsisten
            $status = $row['status'] ?? $row['application_status'] ?? null;

            if (isset($counts[$status])) {
                $counts[$status]++;
            }
        }

        $response = [
            'pending'   => $counts['pending'],
            'accepted'  => $counts['accepted'],
            'completed' => $counts['completed'],
            'rejected'  => $counts['rejected'],
            'total'     => array_sum($counts)
        ];

        return $this->response->setJSON($response);
    }

    public function applicationDetail($applicationId)
    {
        $user = $this->request->user;

        $model = new JobApplicationModel();

        $data = $model
            ->select(
                'job_applications.id as application_id,
                 job_applications.status as application_status,
                 job_applications.applied_at,
                 jobs.*'
            )
            ->join('jobs', 'jobs.id = job_applications.job_id')
            ->where('job_applications.id', $applicationId)
            ->where('job_applications.user_id', $user->id)
            ->first();

        if (!$data) {
            return $this->response
                ->setStatusCode(404)
                ->setJSON(['message' => 'Application not found']);
        }

        return $this->response->setJSON($data);
    }

    /**
     * ============================
     * LIST JOBS FOR WORKER
     * ============================
     * GET /api/worker/jobs
     */
    public function jobs()
    {
        $user = $this->request->user;

        if (!$user || $user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        // =========================
        // 1️⃣ Ambil category dari skill worker
        // =========================
        $categoryRows = $this->workerSkill
            ->select('skills.category')
            ->join('skills', 'skills.id = worker_skills.skill_id')
            ->where('worker_skills.user_id', $user->id)
            ->get()
            ->getResultArray();

        $myCategories = array_unique(array_column($categoryRows, 'category'));

        if (empty($myCategories)) {
            return $this->response->setJSON([]);
        }

        // =========================
        // 2️⃣ Ambil semua skill.name dalam category tersebut
        // =========================
        $skillRows = $this->skill
            ->whereIn('category', $myCategories)
            ->get()
            ->getResultArray();

        $allowedPositions = array_column($skillRows, 'name');

        if (empty($allowedPositions)) {
            return $this->response->setJSON([]);
        }

        // =========================
        // 3️⃣ Ambil jobs sesuai posisi dalam category itu
        // =========================
        $jobs = $this->job
            ->whereIn('position', $allowedPositions)
            ->where('status', 'open')
            ->orderBy('job_date_start', 'DESC')
            ->findAll();

        return $this->response->setJSON($jobs);
    }
    
    /**
     * ============================
     * MOST POPULAR JOBS
     * ============================
     * GET /api/jobs/most-popular
     */
    public function mostPopular()
    {
        $user = $this->request->user;

        if (!$user || $user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        $db = \Config\Database::connect();

        // =========================
        // 1️⃣ Ambil category worker
        // =========================
        $categoryRows = $this->workerSkill
            ->select('skills.category')
            ->join('skills', 'skills.id = worker_skills.skill_id')
            ->where('worker_skills.user_id', $user->id)
            ->get()
            ->getResultArray();

        $myCategories = array_unique(array_column($categoryRows, 'category'));

        if (empty($myCategories)) {
            return $this->response->setJSON([]);
        }

        // =========================
        // 2️⃣ Ambil semua skill dalam category tersebut
        // =========================
        $skillRows = $this->skill
            ->whereIn('category', $myCategories)
            ->get()
            ->getResultArray();

        $allowedPositions = array_column($skillRows, 'name');

        if (empty($allowedPositions)) {
            return $this->response->setJSON([]);
        }

        // =========================
        // 3️⃣ Ambil job populer sesuai category worker
        // =========================
        $jobs = $db->table('job_applications ja')
            ->select('
                j.*,
                h.hotel_name,
                h.logo AS hotel_logo,
                COUNT(ja.id) AS total_apply
            ')
            ->join('jobs j', 'j.id = ja.job_id')
            ->join('hotels h', 'h.id = j.hotel_id', 'left')
            ->whereIn('j.position', $allowedPositions)
            ->where('j.status', 'open')
            ->groupBy('j.id')
            ->orderBy('total_apply', 'DESC')
            ->limit(5)
            ->get()
            ->getResultArray();

        return $this->response->setJSON($jobs);
    }

    /**
     * ============================
     * LIST ATTENDANCE (SCHEDULE)
     * ============================
     * GET /api/worker/attendance
     * optional: ?date=YYYY-MM-DD
     */
    public function attendance()
    {
        $user = $this->request->user;

        if ($user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Access denied']);
        }

        $date = $this->request->getGet('date');

        $builder = $this->attendance
            ->select('
                job_attendances.*,

                jobs.position,
                jobs.job_date_start,
                jobs.job_date_end,

                training_shifts.training_day_id,
                training_days.training_date,
                training_plans.title as training_title,

                hotels.hotel_name
            ')
            ->join('jobs', 'jobs.id = job_attendances.job_id', 'left')

            // =========================
            // TRAINING JOIN
            // =========================
            ->join('training_shifts', 'training_shifts.id = job_attendances.training_shift_id', 'left')
            ->join('training_days', 'training_days.id = training_shifts.training_day_id', 'left')
            ->join('training_plans', 'training_plans.id = training_days.training_plan_id', 'left')

            // =========================
            // HOTEL JOIN
            // =========================
            ->join('hotels', 'hotels.id = COALESCE(jobs.hotel_id, training_plans.hotel_id)', 'left')

            ->where('job_attendances.user_id', $user->id);

        if ($date) {
            $builder->where('DATE(job_attendances.created_at)', $date);
        }

        $data = $builder
            ->orderBy('job_attendances.created_at', 'ASC')
            ->findAll();

        return $this->response->setJSON($data);
    }

    /**
     * ============================
     * ATTENDANCE BY JOB
     * ============================
     * GET /api/worker/attendance/job/{job_id}
     */
    public function attendanceByJob($jobId)
    {
        $user = $this->request->user;

        $data = $this->attendance
            ->where('job_id', $jobId)
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'ASC')
            ->findAll();

        return $this->response->setJSON($data);
    }

    /**
     * ============================
     * CHECK-IN
     * ============================
     * POST /api/worker/attendance/checkin
     */
    public function checkin()
    {
        $user = $this->request->user;
        $data = $this->request->getPost();

        $isTraining = !empty($data['training_shift_id']);

        // =========================
        // VALIDATION
        // =========================
        if ($isTraining) {

            foreach (['training_shift_id','latitude','longitude'] as $f) {
                if (empty($data[$f])) {
                    return $this->response
                        ->setStatusCode(400)
                        ->setJSON(['message' => "$f is required"]);
                }
            }

        } else {

            foreach (['job_id','application_id','latitude','longitude'] as $f) {
                if (empty($data[$f])) {
                    return $this->response
                        ->setStatusCode(400)
                        ->setJSON(['message' => "$f is required"]);
                }
            }

        }

        // =========================
        // PREVENT DOUBLE CHECKIN
        // =========================
        $builder = $this->attendance
            ->where('user_id', $user->id)
            ->where('type', 'checkin')
            ->where('DATE(created_at)', date('Y-m-d'));

        if ($isTraining) {

            $builder->where('training_shift_id', $data['training_shift_id']);

        } else {

            $builder->where('job_id', $data['job_id'])
                    ->where('application_id', $data['application_id']);

        }

        $exists = $builder->first();

        if ($exists) {
            return $this->response
                ->setStatusCode(409)
                ->setJSON(['message' => 'Already checked-in today']);
        }

        // =========================
        // HANDLE SELFIE
        // =========================
        $selfieBase64 = $data['selfie'] ?? null;
        $photoPath = null;

        if ($selfieBase64) {

            $imageData = base64_decode($selfieBase64);

            if ($imageData === false) {
                return $this->response
                    ->setStatusCode(400)
                    ->setJSON(['message' => 'Invalid selfie data']);
            }

            $name = 'checkin_' . $user->id . '_' . time() . '.jpg';

            $dir = FCPATH . 'uploads/attendance/';
            $photoPath = 'uploads/attendance/' . $name;

            if (!is_dir($dir)) {
                mkdir($dir, 0777, true);
            }

            file_put_contents($dir . $name, $imageData);
        }

        // =========================
        // INSERT ATTENDANCE
        // =========================
        $insert = [
            'user_id'       => $user->id,
            'type'          => 'checkin',
            'latitude'      => $data['latitude'],
            'longitude'     => $data['longitude'],
            'photo_path'    => $photoPath,
            'device_info'   => $this->request->getUserAgent()->getAgentString(),
            'created_at'    => $data['device_time'] ?? date('Y-m-d H:i:s'),
            'created_by'    => $user->id
        ];

        if ($isTraining) {

            $insert['training_shift_id'] = $data['training_shift_id'];

        } else {

            $insert['job_id'] = $data['job_id'];
            $insert['application_id'] = $data['application_id'];

        }

        $this->attendance->insert($insert);

        return $this->response->setJSON([
            'message' => $isTraining
                ? 'Training check-in success'
                : 'Check-in success'
        ]);
    }

    /**
     * ============================
     * CHECK-OUT
     * ============================
     * POST /api/worker/attendance/checkout
     */
    public function checkout()
    {
        $data = $this->request->getPost();
        $user = $this->request->user ?? null;

        $db = \Config\Database::connect();

        /*
        ======================================
        EARLY CHECKOUT BY MANAGER
        ======================================
        */

        if (!empty($data['early'])) {

            if (!in_array(session('user_role'), [
                'admin','hotel_hr','hotel_fo','hotel_hk','hotel_fnb_service',
                'hotel_fnb_production','hotel_fna','hotel_eng','hotel_sales','hotel_gm'
            ])) {
                return $this->response->setJSON([
                    'status' => false,
                    'message' => 'Unauthorized'
                ]);
            }

            foreach (['user_id','job_id','date'] as $f) {
                if (empty($data[$f])) {
                    return $this->response
                        ->setStatusCode(400)
                        ->setJSON(['message' => "$f is required"]);
                }
            }

            // ambil checkin
            $checkin = $this->attendance
                ->where('job_id', $data['job_id'])
                ->where('user_id', $data['user_id'])
                ->where('type', 'checkin')
                ->where('DATE(created_at)', $data['date'])
                ->first();

            if (!$checkin) {
                return $this->response
                    ->setJSON([
                        'status' => false,
                        'message' => 'Worker has not checked in'
                    ]);
            }

            // cek sudah checkout
            $checkout = $this->attendance
                ->where('job_id', $data['job_id'])
                ->where('user_id', $data['user_id'])
                ->where('type', 'checkout')
                ->where('DATE(created_at)', $data['date'])
                ->first();

            if ($checkout) {
                return $this->response->setJSON([
                    'status' => false,
                    'message' => 'Worker already checkout'
                ]);
            }

            $this->attendance->insert([
                'job_id'         => $data['job_id'],
                'application_id' => $checkin['application_id'],
                'user_id'        => $data['user_id'],
                'type'           => 'checkout',
                'latitude'       => -6.6011188,
                'longitude'      => 106.7941239,
                'photo_path'     => null,
                'device_info'    => 'EARLY CHECKOUT BY ' . session('user_role'),
                'created_by'     => session('user_id')
            ]);

            return $this->response->setJSON([
                'status' => true,
                'checkout_time' => date('H:i:s'),
                'message' => 'Early checkout success'
            ]);
        }

        /*
        ======================================
        NORMAL CHECKOUT BY WORKER
        ======================================
        */

        foreach (['job_id','application_id','latitude','longitude'] as $f) {
            if (empty($data[$f])) {
                return $this->response
                    ->setStatusCode(400)
                    ->setJSON(['message' => "$f is required"]);
            }
        }

        // wajib sudah checkin
        $checkin = $this->attendance
            ->where('job_id', $data['job_id'])
            ->where('application_id', $data['application_id'])
            ->where('user_id', $user->id)
            ->where('type', 'checkin')
            ->where('DATE(created_at)', date('Y-m-d'))
            ->first();

        if (!$checkin) {
            return $this->response
                ->setStatusCode(409)
                ->setJSON(['message' => 'You must check-in first']);
        }

        $selfieBase64 = $data['selfie'] ?? null;
        $photoPath = null;

        if ($selfieBase64) {

            $imageData = base64_decode($selfieBase64);

            if ($imageData === false) {
                return $this->response
                    ->setStatusCode(400)
                    ->setJSON(['message' => 'Invalid selfie data']);
            }

            $name = 'checkout_' . $data['job_id'] . '_' . $user->id . '_' . time() . '.jpg';

            $dir = FCPATH . 'uploads/attendance/';
            $photoPath = 'uploads/attendance/' . $name;

            if (!is_dir($dir)) {
                mkdir($dir, 0777, true);
            }

            file_put_contents($dir . $name, $imageData);
        }

        $this->attendance->insert([
            'job_id'        => $data['job_id'],
            'application_id'=> $data['application_id'],
            'user_id'       => $user->id,
            'type'          => 'checkout',
            'latitude'      => $data['latitude'],
            'longitude'     => $data['longitude'],
            'photo_path'    => $photoPath,
            'device_info'   => $this->request->getUserAgent()->getAgentString(),
            'created_by'    => $user->id
        ]);

        return $this->response->setJSON([
            'message' => 'Check-out success'
        ]);
    }

    public function schedule()
    {
        $db = \Config\Database::connect();

        $userId = $this->request->user->id ?? null;
        if (!$userId) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Unauthorized'
            ]);
        }

        $rows = $db->table('schedule_shifts ss')
            ->select('
                ss.id as schedule_shift_id,
                sd.shift_date,

                TIME_FORMAT(DATE_SUB(ss.start_time, INTERVAL 30 MINUTE), "%H:%i:%s") as start_time,

                ss.end_time,
                ss.shift_type,
                ss.application_id,
                ss.job_id,
                sp.department,
                sp.status,
                sp.hotel_id,
                h.hotel_name,
                h.latitude,
                h.longitude
            ')
            ->join('schedule_days sd', 'sd.id = ss.schedule_day_id')
            ->join('schedule_plans sp', 'sp.id = sd.schedule_plan_id')
            ->join('hotels h', 'h.id = sp.hotel_id')
            ->where('ss.user_id', $userId)
            ->where('sp.status', 'approved')
            ->orderBy('sd.shift_date', 'ASC')
            ->orderBy('ss.start_time', 'ASC')
            ->get()
            ->getResultArray();

        // ===============================
        // GROUP BY DATE
        // ===============================
        $grouped = [];

        foreach ($rows as $row) {
            $date = $row['shift_date'];

            if (!isset($grouped[$date])) {
                $grouped[$date] = [
                    'shift_date' => $date,
                    'shifts'     => []
                ];
            }

            $grouped[$date]['shifts'][] = [
                'schedule_shift_id' => $row['schedule_shift_id'],
                'start_time'        => $row['start_time'],
                'end_time'          => $row['end_time'],
                'shift_type'        => $row['shift_type'],
                'department'        => $row['department'],
                'hotel_id'          => $row['hotel_id'],
                'hotel_name'        => $row['hotel_name'],
                'hotel_latitude'    => $row['latitude'],
                'hotel_longitude'   => $row['longitude'],
                'application_id'    => $row['application_id'],
                'job_id'            => $row['job_id'],
            ];
        }

        return $this->response->setJSON([
            'status' => true,
            'data'   => array_values($grouped)
        ]);
    }

    public function trainingList()
    {
        $user = $this->request->user;

        if (!$user || $user->role !== 'worker') {
            return $this->response
                ->setStatusCode(403)
                ->setJSON([
                    'status' => false,
                    'message' => 'Access denied'
                ]);
        }

        $db = \Config\Database::connect();

        $rows = $db->table('training_shifts ts')
            ->select('
                ts.id,
                td.training_date,
                ts.start_time,
                ts.end_time,
                ts.shift_type,
                ts.job_id,
                ts.application_id,

                tp.id as training_id,
                tp.title,
                tp.description,
                tp.department,
                tp.status,

                h.id as hotel_id,
                h.hotel_name,
                h.latitude,
                h.longitude
            ')
            ->join('training_days td', 'td.id = ts.training_day_id')
            ->join('training_plans tp', 'tp.id = td.training_plan_id')
            ->join('hotels h', 'h.id = tp.hotel_id', 'left')
            ->where('ts.user_id', $user->id)
            ->where('tp.status', 'approved')
            ->orderBy('td.training_date','ASC')
            ->orderBy('ts.start_time','ASC')
            ->get()
            ->getResultArray();

        // ===============================
        // GROUP BY DATE
        // ===============================
        $grouped = [];

        foreach ($rows as $row) {

            $date = $row['training_date'];

            if (!isset($grouped[$date])) {
                $grouped[$date] = [
                    'training_date' => $date,
                    'shifts'        => []
                ];
            }

            $grouped[$date]['shifts'][] = [
                'training_shift_id' => $row['id'],
                'start_time'        => $row['start_time'],
                'end_time'          => $row['end_time'],
                'shift_type'        => $row['shift_type'],
                
                'job_id'            => $row['job_id'],
                'application_id'    => $row['application_id'],

                'training_id'       => $row['training_id'],
                'title'             => $row['title'],
                'description'       => $row['description'],
                'department'        => $row['department'],

                'hotel_id'          => $row['hotel_id'],
                'hotel_name'        => $row['hotel_name'],
                'hotel_latitude'    => $row['latitude'],
                'hotel_longitude'   => $row['longitude'],
            ];
        }

        return $this->response->setJSON([
            'status' => true,
            'data'   => array_values($grouped)
        ]);
    }

    public function pushNotificationRegister()
    {
        return;
    }
}
