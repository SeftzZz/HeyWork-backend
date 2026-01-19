<?php

namespace App\Models;

use CodeIgniter\Model;

class SkillModel extends Model
{
    protected $table = 'skills';
    protected $allowedFields = [
    	'name',
    	'created_at','created_by','updated_at','updated_by','deleted_at','deleted_by'
    ];
    protected $useTimestamps = true;
}
