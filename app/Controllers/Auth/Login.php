<?php

namespace App\Controllers\Auth;

use App\Controllers\BaseController;
use App\Models\UserModel;
use App\Models\HotelModel;
use CodeIgniter\Email\Email;

class Login extends BaseController
{
    protected $users;

    public function __construct()
    {
        $this->users = new UserModel();
    }

    public function index()
    {
        return view('auth/login', [
            'title' => 'Login | Hey! Work'
        ]);
    }

    public function auth()
    {
        $email = $this->request->getPost('email');
        $password = $this->request->getPost('password');

        $user = $this->users
            ->where('email', $email)
            ->where('is_active', 'active')
            ->where('deleted_at', null)
            ->first();

        if (!$user) {
            return redirect()->back()->with('error', 'User not found');
        }

        if (!$user['is_active']) {
            return redirect()->back()->with('error', 'User is inactive');
        }

        if (!password_verify($password, $user['password'])) {
            return redirect()->back()->with('error', 'Incorrect password');
        }

        $hotelModel = new HotelModel();
        $hotel = $hotelModel->find($user['hotel_id']);

        session()->set([
            'user_id'        => $user['id'],
            'hotel_id'       => $user['hotel_id'],
            'hotel_name'     => $hotel['hotel_name'] ?? null,
            'hotel_email'    => $hotel['email'] ?? null,
            'user_name'      => $user['name'],
            'user_role'      => $user['role'],
            'user_email'     => $user['email'],
            'user_photo'     => $user['photo'],
            'isLoggedIn'     => true
        ]);

        return redirect()->to('/admin/dashboard');
    }

    public function logout()
    {
        session()->destroy();
        return redirect()->to('/login');
    }

    public function forgotPassword()
    {
        return view('auth/forgotpass', [
            'title' => 'Forgot Password | Hey! Work'
        ]);
    }

    public function sendResetLink()
    {
        $email = $this->request->getPost('email');

        $user = $this->users
            ->where('email', $email)
            ->where('deleted_at', null)
            ->first();

        if (!$user) {
            return redirect()->back()->with('error', 'Email not registered');
        }

        // buat token
        $token = bin2hex(random_bytes(32));
        // $token = md5(uniqid());

        $this->users->update($user['id'], [
            'reset_token'   => $token,
            'reset_expired' => date('Y-m-d H:i:s', strtotime('+1 hour'))
        ]);

        // buat link reset
        $resetLink = base_url('reset-password?token=' . $token);

        // kirim email
        $emailService = \Config\Services::email();
        $emailService->setFrom('no-reply@heywork.id', 'no-reply@heywork.id');
        $emailService->setTo($email);
        $emailService->setSubject('Reset Password Notification - Hey! Work');
        $emailService->setMailType('html');
        // $emailService->setMessage("
        //     Hello {$user['name']},<br><br>
        //     Click the link below to reset your password:<br><br>
        //     <a href='{$resetLink}'>Reset Password</a><br><br>
        //     This link will expire in 1 hour.
        // ");

        $emailService->setMessage("
            <!DOCTYPE html>
            <html>
            <head>
            <meta charset='UTF-8'>
            <title>Reset Password</title>
            </head>

            <body style='margin:0;padding:0;background:#f5f5f5;font-family:Arial,Helvetica,sans-serif;'>

            <table width='100%' cellpadding='0' cellspacing='0' style='background:#f5f5f5;padding:30px 0;'>
            <tr>
            <td align='center'>

            <table width='600' cellpadding='0' cellspacing='0' style='background:#ffffff;border-radius:6px;overflow:hidden;'>

            <!-- HEADER -->
            <tr>
            <td style='background:#FFFFFF;padding:20px;text-align:center;'>
                <img src='".base_url("assets/img/logo01.png")."' style='height:40px;'>
            </td>
            </tr>

            <!-- CONTENT -->
            <tr>
            <td style='padding:40px;'>

            <h2 style='margin-top:0;color:#333;'>Reset Your Password</h2>

            <p style='color:#555;font-size:14px;line-height:22px;'>
            Hello <b>{$user['name']}</b>,
            </p>

            <p style='color:#555;font-size:14px;line-height:22px;'>
            We received a request to reset your password for your <b>Hey! Work</b> account.
            Click the button below to create a new password.
            </p>

            <p style='text-align:center;margin:30px 0;'>
            <a href='{$resetLink}' 
            style='background:#FFD400;color:#000;text-decoration:none;padding:14px 28px;border-radius:4px;font-weight:bold;display:inline-block;'>
            Reset Password
            </a>
            </p>

            <p style='color:#777;font-size:13px;line-height:20px;'>
            This password reset link will expire in <b>1 hour</b>.
            </p>

            <p style='color:#777;font-size:13px;line-height:20px;'>
            If you did not request a password reset, please ignore this email.
            </p>

            </td>
            </tr>

            <!-- FOOTER -->
            <tr>
            <td style='background:#f1f1f1;padding:20px;text-align:center;font-size:12px;color:#777;'>
            © ".date('Y')." Hey! Work. All rights reserved.
            </td>
            </tr>

            </table>

            </td>
            </tr>
            </table>

            </body>
            </html>
        ");

        if ($emailService->send()) {
            return redirect()->back()->with('success', 'Reset link sent to your email');
        } else {
            // return redirect()->back()->with('error', 'Failed to send email');
            echo $emailService->printDebugger(['headers']);
            exit;
        }
    }

    public function resetPassword()
    {
        $token = $this->request->getGet('token');

        $user = $this->users
            ->where('reset_token', $token)
            ->where('reset_expired >=', date('Y-m-d H:i:s'))
            ->first();

        if (!$user) {
            return redirect()->to('/login')->with('error', 'Invalid or expired reset link');
        }

        return view('auth/resetpass', [
            'title' => 'Reset Password',
            'token' => $token,
            'email' => $user['email']
        ]);
    }

    public function updatePassword()
    {
        $token = $this->request->getPost('token');
        $password = $this->request->getPost('password');
        if (!preg_match('/^(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/', $password)) {
            return redirect()->back()->with('error',
                'Password must be at least 8 characters and contain a special character'
            );
        }

        $user = $this->users
            ->where('reset_token', $token)
            ->where('reset_expired >=', date('Y-m-d H:i:s'))
            ->first();

        if (!$user) {
            return redirect()->to('/login')->with('error', 'Invalid token');
        }

        $this->users->update($user['id'], [
            'password'      => password_hash($password, PASSWORD_DEFAULT),
            'reset_token'   => null,
            'reset_expired' => null
        ]);

        return redirect()->to('/login')->with('success', 'Password successfully reset');
    }
}
