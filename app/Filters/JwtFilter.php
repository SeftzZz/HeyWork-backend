<?php

namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
use App\Libraries\JwtService;   // ✅ BENAR
use Config\Services;            // ✅ WAJIB

class JwtFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        $header = $request->getHeaderLine('Authorization');

        if (!$header) {
            return Services::response()
                ->setStatusCode(401)
                ->setJSON(['message' => 'Token not provided']);
        }

        $token = str_replace('Bearer ', '', $header);

        try {
            $jwtService = new JwtService();
            $decoded = $jwtService->validateAccessToken($token);

            // ✅ SESUAI DENGAN PAYLOAD JWT
            $request->user = (object) $decoded->data;

        } catch (\Exception $e) {
            return Services::response()
                ->setStatusCode(401)
                ->setJSON([
                    'message' => 'Invalid or expired token',
                    'error'   => $e->getMessage()
                ]);
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // nothing
    }
}
