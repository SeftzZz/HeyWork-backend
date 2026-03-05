<?php

namespace App\Controllers\Admin;

use App\Models\JobModel;
use App\Models\SkillModel;
use CodeIgniter\Controller;

class JobVacancies extends BaseAdminController
{
    protected $job;

    public function initController(
        \CodeIgniter\HTTP\RequestInterface $request,
        \CodeIgniter\HTTP\ResponseInterface $response,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::initController($request, $response, $logger);

        $this->job = new JobModel();
        $this->skills = new SkillModel();
    }

    public function index()
    {
        return view('admin/job-vacancies/index', [
            'title' => 'Job Vacancies',
            'skills' => $this->skills
                ->where('deleted_at', null)
                ->orderBy('name', 'ASC')
                ->findAll()
        ]);
    }

    /**
     * ============================
     * DATATABLE JOB VACANCIES
     * ============================
     */
    public function datatable()
    {
        $request = service('request');

        $search = $request->getPost('search')['value'] ?? null;
        $length = (int) $request->getPost('length');
        $start  = (int) $request->getPost('start');
        $draw   = (int) $request->getPost('draw');
        $order  = $request->getPost('order');

        $columns = [
            null,
            'jobs.position',
            'jobs.category',
            'jobs.job_date_start',
            'jobs.start_time',
            'jobs.location',
            'jobs.fee',
            'jobs.status'
        ];

        $db = \Config\Database::connect();

        $builder = $db->table('jobs')
            ->select("
                jobs.id,
                jobs.position,
                jobs.category,
                jobs.job_date_start,
                jobs.job_date_end,
                jobs.location,
                jobs.fee,
                jobs.status
            ")
            ->where('jobs.hotel_id', session()->get('hotel_id'))
            ->where('jobs.deleted_at IS NULL');

        // SEARCH
        if ($search) {
            // bersihkan format rupiah (hapus titik & koma)
            $numericSearch = str_replace(['.', ','], '', $search);

            $builder->groupStart()
                ->like('jobs.position', $search)
                ->orLike('jobs.category', $search)
                ->orLike('jobs.location', $search)
                ->orLike('jobs.status', $search);

            // kalau numeric, search ke fee juga
            if (is_numeric($numericSearch)) {
                $builder->orWhere('jobs.fee', (int)$numericSearch);
            }

            $builder->groupEnd();
        }

        // COUNT
        $countBuilder    = clone $builder;
        $recordsFiltered = $countBuilder->countAllResults(false);
        $recordsTotal    = $recordsFiltered;

        // ORDER
        if ($order && isset($order[0]['column'])) {
            $idx = (int) $order[0]['column'];
            if (!empty($columns[$idx])) {
                $builder->orderBy($columns[$idx], $order[0]['dir']);
            } else {
                $builder->orderBy('jobs.id', 'DESC');
            }
        } else {
            $builder->orderBy('jobs.id', 'DESC');
        }

        // LIMIT
        if ($length > 0) {
            $builder->limit($length, $start);
        }

        $rows = $builder->get()->getResultArray();

        $data = [];
        $no   = $start + 1;

        foreach ($rows as $row) {

            $badgeStatus = $row['status'] === 'open'
                ? '<span class="badge bg-label-success">Open</span>'
                : '<span class="badge bg-label-secondary">Closed</span>';

            $data[] = [
                'no'       => $no++ . '.',
                'position' => esc($row['position']),
                'category' => ucfirst(str_replace('_', ' ', $row['category'])),
                'date'     => date('d-m-Y', strtotime($row['job_date_start']))
                              . ' s/d ' .
                              date('d-m-Y', strtotime($row['job_date_end'])),
                'location' => esc($row['location']),
                'fee'      => number_format($row['fee'], 0, ',', '.'),
                'status'   => $badgeStatus,
                'action' => '
                    <button 
                        class="btn btn-sm btn-warning btn-edit-job"
                        data-id="' . (int)$row['id'] . '">
                        <i class="ti ti-edit"></i>
                    </button>
                '
            ];
        }

        return $this->response->setJSON([
            'draw'            => $draw,
            'recordsTotal'    => $recordsTotal,
            'recordsFiltered' => $recordsFiltered,
            'data'            => $data
        ]);
    }

    public function store()
    {
        $data = $this->request->getPost();

        // =========================
        // VALIDASI & KONVERSI DATE
        // =========================
        try {
            $jobDateStart = \DateTime::createFromFormat('Y-m-d', $data['job_date_start']);
            $jobDateEnd   = \DateTime::createFromFormat('Y-m-d', $data['job_date_end']);

            if (!$jobDateStart || !$jobDateEnd) {
                throw new \Exception('Invalid date format');
            }

            $jobDateStart = $jobDateStart->format('Y-m-d');
            $jobDateEnd   = $jobDateEnd->format('Y-m-d');
        } catch (\Exception $e) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Invalid job date format'
            ]);
        }

        // =========================
        // VALIDASI TIME
        // =========================
        if (strtotime($data['end_time']) <= strtotime($data['start_time'])) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'End time must be greater than start time'
            ]);
        }

        // =========================
        // VALIDASI POSITION (MULTI)
        // =========================
        if (empty($data['position'])) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Please select job position'
            ]);
        }

        $db = \Config\Database::connect();
        $builder = $db->table('jobs');

        $now     = date('Y-m-d H:i:s');
        $userId = session()->get('user_id');
        $hotelId = session()->get('hotel_id');

        // =========================
        // AMBIL LOCATION DARI HOTEL
        // =========================
        $hotel = $db->table('hotels')->select('location')->where('id', $hotelId)->get()->getRowArray();

        if (!$hotel) {
            return $this->response->setJSON([
                'status'  => false,
                'message' => 'Hotel not found'
            ]);
        }

        $insert = [
            'hotel_id'       => $hotelId,
            'position'       => $data['position'],
            'category'       => $data['category'],
            'job_date_start' => $jobDateStart,
            'job_date_end'   => $jobDateEnd,
            'start_time'     => $data['start_time'],
            'end_time'       => $data['end_time'],
            'fee'            => $data['fee'],
            'location'       => $hotel['location'],
            'description'    => $data['description'] ?? null,
            'status'         => 'open',
            'created_at'     => $now,
            'created_by'     => $userId
        ];

        $builder->insert($insert);

        return $this->response->setJSON([
            'status'  => true,
            'message' => 'Job(s) have been successfully created'
        ]);
    }

    public function get()
    {
        $id = $this->request->getPost('id');
        $job = $this->job->where('id', $id)->where('deleted_at IS NULL')->first();

        if (!$job) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Job not found'
            ]);
        }

        return $this->response->setJSON([
            'status' => true,
            'data'   => $job
        ]);
    }

    public function update()
    {
        $data = $this->request->getPost();
        $id   = $data['id'] ?? null;

        if (!$id) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Invalid ID'
            ]);
        }

        $job = $this->job->find($id);

        if (!$job) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Job not found'
            ]);
        }

        // =========================
        // VALIDASI DATE
        // =========================
        try {
            $start = new \DateTime($data['job_date_start']);
            $end   = new \DateTime($data['job_date_end']);

            $jobDateStart = $start->format('Y-m-d');
            $jobDateEnd   = $end->format('Y-m-d');

        } catch (\Exception $e) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Invalid date format'
            ]);
        }

        // =========================
        // VALIDASI TIME
        // =========================
        if (strtotime($data['end_time']) <= strtotime($data['start_time'])) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'End time must be greater than start time'
            ]);
        }

        // =========================
        // AMBIL LOCATION DARI HOTEL
        // =========================
        $hotelId = session()->get('hotel_id');

        $db = \Config\Database::connect();
        $hotel = $db->table('hotels')->select('location')->where('id', $hotelId)->get()->getRowArray();

        if (!$hotel) {
            return $this->response->setJSON([
                'status' => false,
                'message' => 'Hotel not found'
            ]);
        }

        $update = [
            'position'       => $data['position'],
            'category'       => $data['category'],
            'job_date_start' => $jobDateStart,
            'job_date_end'   => $jobDateEnd,
            'start_time'     => $data['start_time'],
            'end_time'       => $data['end_time'],
            'fee'            => $data['fee'],
            'location'       => $hotel['location'], // AUTO FROM HOTEL ID di Session
            'description'    => $data['description'] ?? null,
            'updated_at'     => date('Y-m-d H:i:s'),
            'updated_by'     => session()->get('user_id')
        ];

        $this->job->update($id, $update);

        return $this->response->setJSON([
            'status' => true,
            'message' => 'Job successfully updated'
        ]);
    }

    public function skills()
    {
        $search = $this->request->getGet('q');

        $db = \Config\Database::connect();

        $builder = $db->table('skills')
            ->select('id, name')
            ->where('deleted_at', null);

        if ($search) {
            $builder->like('name', $search);
        }

        $skills = $builder
            ->orderBy('name', 'ASC')
            ->limit(20)
            ->get()
            ->getResultArray();

        $results = [];

        foreach ($skills as $skill) {
            $results[] = [
                'id'   => $skill['name'], // ⬅️ value yang dikirim ke form
                'text' => $skill['name']
            ];
        }

        return $this->response->setJSON([
            'results' => $results
        ]);
    }

    public function getCoorporateJobs()
    {
        $db = \Config\Database::connect();

        $jobs = $db->table('jobs')
            ->select('id, position, job_date_start')
            ->where('category', 'coorporate')
            ->where('status', 'open')
            ->get()
            ->getResultArray();

        return $this->response->setJSON($jobs);
    }

    public function getTotalJobPostings()
    {
        if (!$this->request->isAJAX()) {
            return $this->response->setStatusCode(404);
        }

        $db = \Config\Database::connect();

        $total = $db->table('jobs')
            ->where('hotel_id', session()->get('hotel_id'))
            ->whereIn('category', ['daily_worker', 'casual'])
            ->where('deleted_at', null)
            ->countAllResults();

        return $this->response->setJSON([
            'status' => true,
            'total'  => $total
        ]);
    }
}
