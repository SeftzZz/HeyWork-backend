<?php

namespace App\Models;

use CodeIgniter\Model;

class ManpowerReqModel extends Model
{
    protected $table            = 'manpower_requests';
    protected $primaryKey       = 'id';
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;

    protected $allowedFields = [
        'hotel_id',
        'position_id',
        'requested_by',
        'manpower_needed',
        'reason',
        'hrm_id',
        'hrm_approval',
        'hrm_note',
        'gm_id',
        'gm_approval',
        'gm_note',
        'status',
        'created_at',
        'created_by',
        'updated_at',
        'updated_by',
        'deleted_at',
        'deleted_by'
    ];
}