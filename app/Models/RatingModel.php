<?php

namespace App\Models;

use CodeIgniter\Model;

class RatingModel extends Model
{
    protected $table = 'ratings';
    protected $allowedFields = [
        'job_id',
        'application_id',
        'worker_id',
        'rating',
        'review'
    ];
    protected $useTimestamps = true;
}
