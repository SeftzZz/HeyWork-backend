<?php

namespace App\Libraries;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class JwtLibrary
{
    private $key;

    public function __construct()
    {
        $this->key = env('JWT_SECRET');
    }

    public function generate(array $data)
    {
        $payload = [
            'iss' => 'heywork',
            'iat' => time(),
            'exp' => time() + (60 * 60 * 24), // 1 hari
            'data' => $data
        ];

        return JWT::encode($payload, $this->key, 'HS256');
    }

    public function decode(string $token)
    {
        return JWT::decode($token, new Key($this->key, 'HS256'));
    }
}
