<?php

namespace App\Services;

class InvoiceService
{
    public function generateWeeklyInv($weekKey, $hotelId)
    {
        $db = \Config\Database::connect();
        $db->transStart();

        // CEK DUPLIKAT
        $existing = $db->table('invoices')
            ->where('hotel_id', $hotelId)
            ->where('week_key', $weekKey)
            ->get()
            ->getRow();

        if ($existing && $existing->status === 'paid') {
            return false;
        }

        /*
        =========================
        OVERTIME QUERY
        =========================
        */
        $overtimeSub = "
            SELECT
                application_id,
                TIMESTAMPDIFF(
                    MINUTE,
                    MIN(CASE WHEN type='checkin' THEN created_at END),
                    MAX(CASE WHEN type='checkout' THEN created_at END)
                ) AS overtime_minutes
            FROM job_extend_attendances
            GROUP BY application_id
        ";

        /*
        =========================
        SHIFT DATA
        =========================
        */
        $rows = $db->table('schedule_shifts ss')
            ->select("
                ss.application_id,
                ss.user_id as worker_id,
                j.fee,

                GREATEST(
                    TIMESTAMPDIFF(
                        MINUTE,
                        CONCAT(sd.shift_date,' ',ss.start_time),
                        CONCAT(sd.shift_date,' ',ss.end_time)
                    ) - 60,
                    0
                ) AS shift_minutes,

                IFNULL(ot.overtime_minutes,0) AS overtime_minutes
            ")
            ->join('schedule_days sd','sd.id = ss.schedule_day_id','left')
            ->join('job_applications ja','ja.id = ss.application_id','left')
            ->join('jobs j','j.id = ja.job_id','left')
            ->join("($overtimeSub) ot",'ot.application_id = ss.application_id','left')
            ->where('j.hotel_id',$hotelId)
            ->where("YEARWEEK(sd.shift_date,1)",$weekKey)
            ->get()
            ->getResultArray();

        if(!$rows){
            return false;
        }

        /*
        =========================
        CALCULATION
        =========================
        */

        $invoiceItems = [];
        $totalAmount = 0;

        foreach($rows as $row){
            $shiftMinutes = (int)$row['shift_minutes'];
            $overtimeMinutes = (int)$row['overtime_minutes'];

            if($shiftMinutes <= 0) continue;

            $fee = (float)$row['fee'];
            $rate = $fee / $shiftMinutes;

            $workerFee = $fee + ($overtimeMinutes * $rate);
            $platformFee = $workerFee * 0.10;

            $total = $workerFee + $platformFee;

            $totalAmount += $total;

            $invoiceItems[] = [
                'application_id' => $row['application_id'],
                'worker_id' => $row['worker_id'],
                'minutes' => $shiftMinutes + $overtimeMinutes,
                'worker_fee' => $workerFee,
                'platform_fee' => $platformFee
            ];
        }

        if(!$invoiceItems){
            return false;
        }

        /*
        =========================
        INSERT / UPDATE
        =========================
        */
        if($existing){
            $invoiceId = $existing->id;
            $db->table('invoices')
                ->where('id',$invoiceId)
                ->update([
                    'total_amount'=>$totalAmount,
                    'updated_at'=>date('Y-m-d H:i:s')
                ]);

            $db->table('invoice_items')
                ->where('invoice_id',$invoiceId)
                ->delete();
        }else{
            $invoiceNumber = 'INV-'.$hotelId.'-'.$weekKey.'-'.time();

            $db->table('invoices')->insert([
                'invoice_number'=>$invoiceNumber,
                'hotel_id'=>$hotelId,
                'week_key'=>$weekKey,
                'total_amount'=>$totalAmount,
                'status'=>'unpaid',
                'created_at'=>date('Y-m-d H:i:s')
            ]);

            $invoiceId = $db->insertID();
        }

        foreach($invoiceItems as &$item){
            $item['invoice_id']=$invoiceId;
        }

        $db->table('invoice_items')->insertBatch($invoiceItems);

        $db->transComplete();

        return true;
    }
}