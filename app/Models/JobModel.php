<?php

namespace App\Models;

use CodeIgniter\Model;

class JobModel extends Model
{
    protected $table = 'jobs';
    protected $allowedFields = [
        'hotel_name','position','job_date','start_time','end_time','fee','location','description','status',
        'created_at','created_by','updated_at','updated_by','deleted_at','deleted_by'
    ];
    protected $useTimestamps = true;
}
