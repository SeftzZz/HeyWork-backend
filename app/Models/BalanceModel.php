<?php

namespace App\Models;

use CodeIgniter\Model;

class BalanceModel extends Model
{
    protected $table            = 'balances';
    protected $primaryKey       = 'id';
    protected $returnType       = 'array';
    protected $useTimestamps    = false;

    protected $allowedFields = [
        'hotel_id',
        'amount',
        'created_at',
        'updated_at'
    ];

    public function getByHotel($hotelId)
    {
        return $this->where('hotel_id', $hotelId)->first();
    }

    public function increase($hotelId, $amount)
    {
        $balance = $this->getByHotel($hotelId);

        if (!$balance) {
            $this->insert([
                'hotel_id'  => $hotelId,
                'amount'    => $amount,
                'created_at'=> date('Y-m-d H:i:s')
            ]);
            return true;
        }

        return $this->update($balance['id'], [
            'amount'     => $balance['amount'] + $amount,
            'updated_at' => date('Y-m-d H:i:s')
        ]);
    }

    public function decrease($hotelId, $amount)
    {
        $balance = $this->getByHotel($hotelId);

        if (!$balance || $balance['amount'] < $amount) {
            return false; // insufficient balance
        }

        return $this->update($balance['id'], [
            'amount'     => $balance['amount'] - $amount,
            'updated_at' => date('Y-m-d H:i:s')
        ]);
    }
}
