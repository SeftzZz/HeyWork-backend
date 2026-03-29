<?php

namespace App\Models;

use CodeIgniter\Model;

class InvoiceModel extends Model
{
    protected $table            = 'invoices';
    protected $primaryKey       = 'id';
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;

    protected $allowedFields = [
        'invoice_number',
        'hotel_id',
        'week_key',
        'total_amount',
        'status',
        'created_at',
        'created_by'
    ];
}