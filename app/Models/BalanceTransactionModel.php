<?php

namespace App\Models;

use CodeIgniter\Model;

class BalanceTransactionModel extends Model
{
    protected $table         = 'balance_transactions';
    protected $primaryKey    = 'id';
    protected $returnType    = 'array';
    protected $useTimestamps = false;

    protected $allowedFields = [
        'hotel_id',
        'type',
        'amount',
        'description',
        'reference_id',
        'reference_type',
        'created_at',
        'created_by'
    ];

    public function getByHotel($hotelId, $limit = 50)
    {
        return $this->where('hotel_id', $hotelId)
                    ->orderBy('created_at', 'DESC')
                    ->limit($limit)
                    ->findAll();
    }
}
