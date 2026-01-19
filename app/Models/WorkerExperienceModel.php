<?php

namespace App\Models;

use CodeIgniter\Model;

class WorkerExperienceModel extends Model
{
    protected $table = 'worker_experiences';
    protected $allowedFields = [
        'user_id', 'company_name','position','start_date','end_date','description',
        'created_at','created_by','updated_at','updated_by','deleted_at','deleted_by'
    ];
    protected $useTimestamps = true;
}
