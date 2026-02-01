<?php

namespace App\Models;

use CodeIgniter\Model;

class WorkerExperienceModel extends Model
{
    protected $table = 'worker_experiences';
    protected $allowedFields = [
        'user_id',
        'company_name',
        'company_business',
        'job_title',
        'department',
        'location',
        'start_date',
        'end_date',
        'is_current',
        'description',
        'sort_order',
        'created_by',
        'updated_by',
        'deleted_by'
    ];
    protected $useTimestamps = true;
}
