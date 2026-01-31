<?php

namespace App\Models;

use CodeIgniter\Model;

class WorkerSkillModel extends Model
{
    protected $table = 'worker_skills';
    protected $allowedFields = [
    	'user_id', 'skill_id', 'created_at','created_by','updated_at','updated_by','deleted_at','deleted_by'
	];
    protected $useTimestamps = true;
}
