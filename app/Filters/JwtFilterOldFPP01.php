<?php

namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
use App\Libraries\JwtLibrary;

class JwtFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        $authHeader = $request->getHeaderLine('Authorization');

        if (!$authHeader) {
            return service('response')
                ->setStatusCode(401)
                ->setJSON(['message' => 'Authorization header missing']);
        }

        if (!preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            return service('response')
                ->setStatusCode(401)
                ->setJSON(['message' => 'Invalid authorization format']);
        }

        $token = $matches[1];

        try {
            $jwt = new JwtLibrary();
            $decoded = $jwt->decode($token);

            // inject user ke request
            $request->user = $decoded->data;

        } catch (\Exception $e) {
            return service('response')
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
