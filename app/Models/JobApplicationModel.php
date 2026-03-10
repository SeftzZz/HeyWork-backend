<?php

namespace App\Models;

use CodeIgniter\Model;

class JobApplicationModel extends Model
{
    protected $table = 'job_applications';

    protected $allowedFields = [
        'job_id',
        'user_id',
        'status',
        'applied_at'
    ];

    protected $useTimestamps = false;


    public function workerHistory($userId)
    {
        $db = \Config\Database::connect();

        return $db->table('job_applications')
            ->select("
                job_applications.id as application_id,
                job_applications.status as application_status,
                job_applications.applied_at,

                jobs.id as job_id,
                jobs.hotel_id,
                jobs.position,
                jobs.job_date_start,
                jobs.job_date_end,
                jobs.fee,
                jobs.location,

                schedule_days.shift_date,
                schedule_shifts.start_time,
                schedule_shifts.end_time,

                (
                    SELECT MAX(created_at)
                    FROM job_attendances
                    WHERE application_id = job_applications.id
                    AND type = 'checkin'
                ) as last_checkin,

                (
                    SELECT MAX(created_at)
                    FROM job_attendances
                    WHERE application_id = job_applications.id
                    AND type = 'checkout'
                ) as last_checkout

            ")

            ->join('jobs', 'jobs.id = job_applications.job_id')

            ->join(
                'schedule_shifts',
                'schedule_shifts.application_id = job_applications.id
                 AND schedule_shifts.user_id = job_applications.user_id',
                'left'
            )

            ->join(
                'schedule_days',
                'schedule_days.id = schedule_shifts.schedule_day_id',
                'left'
            )

            ->where('job_applications.user_id', $userId)

            ->orderBy('schedule_days.shift_date', 'DESC')
            ->orderBy('schedule_shifts.start_time', 'DESC')

            ->get()
            ->getResultArray();
    }
}