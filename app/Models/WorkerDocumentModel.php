<?php

namespace App\Models;

use CodeIgniter\Model;

class WorkerDocumentModel extends Model
{
    protected $table = 'worker_documents';
    protected $allowedFields = [
        'user_id',
        'type',
        'file_path'
    ];
    protected $useTimestamps = false;
}
