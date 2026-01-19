<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\RatingModel;
use App\Models\JobApplicationModel;

class RatingController extends BaseController
{
    protected $rating;
    protected $application;

    public function __construct()
    {
        $this->rating = new RatingModel();
        $this->application = new JobApplicationModel();
    }

    /**
     * ============================
     * SUBMIT RATING
     * ============================
     */
    public function submit()
    {
        $user = $this->request->user;
        $data = $this->request->getJSON();

        // validasi
        if (!isset($data->application_id, $data->rating)) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'application_id & rating required']);
        }

        if ($data->rating < 1 || $data->rating > 5) {
            return $this->response
                ->setStatusCode(400)
                ->setJSON(['message' => 'Rating must be 1-5']);
        }

        // cek application
        $app = $this->application
            ->where('id', $data->application_id)
            ->where('user_id', $user->id)
            ->where('status', 'completed')
            ->first();

        if (!$app) {
            return $this->response
                ->setStatusCode(403)
                ->setJSON(['message' => 'Job not completed or not yours']);
        }

        // cegah rating dobel
        if ($this->rating
            ->where('application_id', $app['id'])
            ->first()
        ) {
            return $this->response
                ->setStatusCode(409)
                ->setJSON(['message' => 'Already rated']);
        }

        $this->rating->insert([
            'job_id'         => $app['job_id'],
            'application_id'=> $app['id'],
            'worker_id'      => $user->id,
            'rating'         => $data->rating,
            'review'         => $data->review ?? null
        ]);

        return $this->response->setJSON([
            'message' => 'Rating submitted'
        ]);
    }

    /**
     * ============================
     * MY RATINGS
     * ============================
     */
    public function myRatings()
    {
        $user = $this->request->user;

        return $this->response->setJSON(
            $this->rating
                ->where('worker_id', $user->id)
                ->orderBy('created_at', 'DESC')
                ->findAll()
        );
    }
}
