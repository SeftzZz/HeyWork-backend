<?php

namespace App\Libraries;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\JWT as JWTConfig;

class JwtService
{
    protected $config;

    public function __construct()
    {
        $this->config = new JWTConfig();
    }

    public function generateAccessToken($user)
    {
        $payload = [
            'iss' => 'heywork',
            'sub' => $user->id,
            'iat' => time(),
            'exp' => time() + $this->config->accessTokenTTL
        ];

        return JWT::encode($payload, $this->config->secret, $this->config->algo);
    }

    public function generateRefreshToken()
    {
        return bin2hex(random_bytes(64));
    }

    public function validateAccessToken($token)
    {
        return JWT::decode(
            $token,
            new Key($this->config->secret, $this->config->algo)
        );
    }
}
