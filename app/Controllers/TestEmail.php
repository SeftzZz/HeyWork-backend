<?php

namespace App\Controllers;

class TestEmail extends BaseController
{
    public function send()
    {
        $email = \Config\Services::email();

        $email->setFrom('no-reply@heywork.id', 'no-reply@heywork.id');
        $email->setTo('febriansyah@email.com');

        $email->setSubject('Test Email CodeIgniter 4');
        $email->setMessage('<h3>Email berhasil dikirim</h3><p>Ini adalah test email dari CodeIgniter 4.</p>');

        if ($email->send()) {
            echo "Email berhasil dikirim";
        } else {
            echo $email->printDebugger(['headers','subject','body']);
        }
    }
}