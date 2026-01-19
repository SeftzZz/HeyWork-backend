<?php

namespace App\Models;

use CodeIgniter\Model;

class RefreshTokenModel extends Model
{
    protected $table = 'refresh_tokens';
    protected $allowedFields = [
        'user_id',
        'token',
        'expires_at',
        'created_at'
    ];
    public $timestamps = false;
}
