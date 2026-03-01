<?php

namespace Config;

use CodeIgniter\Config\BaseService;
use App\Services\WsEmitter;
use Config\Email;
use CodeIgniter\Email\Email as CIEmail;

class Services extends BaseService
{
    public static function wsEmitter(bool $getShared = true)
    {
        if ($getShared) {
            return static::getSharedInstance('wsEmitter');
        }

        return new WsEmitter();
    }

    // ========================================
    // INVOICE EMAIL SERVICE
    // ========================================
    public static function invoiceEmail(bool $getShared = true)
    {
        if ($getShared) {
            return static::getSharedInstance('invoiceEmail');
        }

        $config = new Email();

        $config->protocol   = 'smtp';
        $config->SMTPHost   = 'smtp.gmail.com';
        $config->SMTPUser   = env('email.SMTPUser');
        $config->SMTPPass   = env('email.SMTPPass');
        $config->SMTPPort   = 587;
        $config->SMTPCrypto = 'tls';
        $config->mailType   = 'html';
        $config->charset    = 'utf-8';
        $config->newline    = "\r\n";

        return new CIEmail($config);
    }
}