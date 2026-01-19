<?php

namespace App\Models;

use CodeIgniter\Model;

class WorkerProfileModel extends Model
{
    protected $table = 'worker_profiles';
    protected $primaryKey = 'id';

    protected $allowedFields = [
        'user_id','gender','birth_date','address','bio',
        'created_at','created_by','updated_at','updated_by','deleted_at','deleted_by'
    ];

    protected $useTimestamps = true;
}
