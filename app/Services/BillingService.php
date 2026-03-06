<?php

namespace App\Services;

use Config\Database;

class BillingService
{
    protected $db;

    public function __construct()
    {
        $this->db = Database::connect();
    }

    public function calculateApplication($applicationId)
    {
        $builder = $this->db->table('job_attendances')
            ->select("
                job_attendances.application_id,
                job_attendances.type,
                job_attendances.created_at,
                users.name AS worker_name,
                jobs.position,
                schedule_shifts.start_time,
                schedule_shifts.end_time,
                schedule_days.shift_date,
                jobs.fee,
                jobs.hotel_id
            ")
            ->join('job_applications', 'job_applications.id = job_attendances.application_id', 'left')
            ->join('users', 'users.id = job_applications.user_id', 'left')
            ->join('jobs', 'jobs.id = job_applications.job_id', 'left')
            ->join(
                'schedule_shifts',
                'schedule_shifts.application_id = job_attendances.application_id
                 AND schedule_shifts.user_id = job_applications.user_id',
                'left'
            )

            ->join(
                'schedule_days',
                'schedule_days.id = schedule_shifts.schedule_day_id',
                'left'
            )
            ->where('job_attendances.application_id', $applicationId)
            ->orderBy('job_attendances.created_at', 'ASC');

        $rows = $builder->get()->getResultArray();

        if (!$rows) {
            return null;
        }

        $data = [
            'application_id' => $applicationId,
            'worker_name'    => $rows[0]['worker_name'],
            'position'       => $rows[0]['position'],
            'start_time'     => $rows[0]['start_time'],
            'end_time'       => $rows[0]['end_time'],
            'fee'            => $rows[0]['fee'],
            'hotel_id'       => $rows[0]['hotel_id'],
            'working_days'   => 0,
            'total_minutes'  => 0,
            'total_amount'   => 0,
            'checkins'       => [],
            'checkouts'      => []
        ];

        // =========================
        // GROUP CHECKIN / CHECKOUT
        // =========================
        foreach ($rows as $row) {
            if ($row['type'] === 'checkin') {
                $data['checkins'][] = $row['created_at'];
            }

            if ($row['type'] === 'checkout') {
                $data['checkouts'][] = $row['created_at'];
            }
        }

        // =========================
        // HITUNG BILLING
        // =========================
        $count = min(count($data['checkins']), count($data['checkouts']));

        for ($i = 0; $i < $count; $i++) {

            $seconds = strtotime($data['checkouts'][$i]) - strtotime($data['checkins'][$i]);
            $minutes = floor($seconds / 60);

            if ($minutes <= 0) {
                continue;
            }

            $data['working_days']++;
            $data['total_minutes'] += $minutes;

            // Billing per 10 menit
            $jobStart   = strtotime($data['start_time']);
            $jobEnd     = strtotime($data['end_time']);
            $jobMinutes = ($jobEnd - $jobStart) / 60;
            $jobTenMin  = floor($jobMinutes / 10);

            if ($jobTenMin > 0 && $data['fee'] > 0) {
                $ratePer10Min = $data['fee'] / $jobTenMin;
                $data['total_amount'] += round(floor($minutes / 10) * $ratePer10Min);
            }
        }

        return $data;
    }
}