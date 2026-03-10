<?php

namespace App\Models;

use CodeIgniter\Model;

class JobAttendanceModel extends Model
{
    protected $table            = 'job_attendances';
    protected $primaryKey       = 'id';
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;

    protected $allowedFields = [
        'job_id',
        'application_id',
        'training_shift_id',
        'user_id',
        'type',
        'latitude',
        'longitude',
        'photo_path',
        'device_info',
        'created_at',
        'created_by',
        'updated_at',
        'updated_by',
        'deleted_at',
        'deleted_by',
    ];

    protected $useTimestamps = false;

    // ============================
    // VALIDATION
    // ============================
    protected $validationRules = [
        'user_id'        => 'required|integer',
        'type'           => 'required|in_list[checkin,checkout]',
        'latitude'       => 'required|decimal',
        'longitude'      => 'required|decimal',

        // shift
        'job_id'         => 'permit_empty|integer',
        'application_id' => 'permit_empty|integer',

        // training
        'training_shift_id' => 'permit_empty|integer',
    ];

    protected $validationMessages = [
        'type' => [
            'in_list' => 'Type must be checkin or checkout'
        ]
    ];

    // ============================
    // HELPERS
    // ============================

    /**
     * Check shift check-in hari ini
     */
    public function hasCheckinToday($userId, $jobId, $applicationId)
    {
        return $this->where('user_id', $userId)
            ->where('job_id', $jobId)
            ->where('application_id', $applicationId)
            ->where('type', 'checkin')
            ->where('DATE(created_at)', date('Y-m-d'))
            ->first();
    }

    /**
     * Check training check-in hari ini
     */
    public function hasTrainingCheckinToday($userId, $trainingShiftId)
    {
        return $this->where('user_id', $userId)
            ->where('training_shift_id', $trainingShiftId)
            ->where('type', 'checkin')
            ->where('DATE(created_at)', date('Y-m-d'))
            ->first();
    }

    /**
     * Check shift checkout
     */
    public function hasCheckoutToday($userId, $jobId, $applicationId)
    {
        return $this->where('user_id', $userId)
            ->where('job_id', $jobId)
            ->where('application_id', $applicationId)
            ->where('type', 'checkout')
            ->where('DATE(created_at)', date('Y-m-d'))
            ->first();
    }

    /**
     * Attendance harian worker (calendar)
     */
    public function dailyAttendance($userId, $date)
    {
        return $this->select('
                job_attendances.*,
                jobs.position,
                jobs.job_date_start,
                jobs.job_date_end,
                hotels.hotel_name
            ')
            ->join('jobs', 'jobs.id = job_attendances.job_id', 'left')
            ->join('hotels', 'hotels.id = jobs.hotel_id', 'left')
            ->where('job_attendances.user_id', $userId)
            ->where('DATE(job_attendances.created_at)', $date)
            ->orderBy('job_attendances.created_at', 'ASC')
            ->findAll();
    }

    /**
     * Attendance per job
     */
    public function attendanceByJob($userId, $jobId)
    {
        return $this->where('user_id', $userId)
            ->where('job_id', $jobId)
            ->orderBy('created_at', 'ASC')
            ->findAll();
    }

    /**
     * Attendance per training
     */
    public function attendanceByTraining($userId, $trainingShiftId)
    {
        return $this->where('user_id', $userId)
            ->where('training_shift_id', $trainingShiftId)
            ->orderBy('created_at', 'ASC')
            ->findAll();
    }
}