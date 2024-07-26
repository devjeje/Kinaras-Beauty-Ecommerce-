<?php

namespace Midtrans\integration;

use Midtrans\Config;

abstract class IntegrationTest extends \PHPUnit_Framework_TestCase
{
    public static function setUpBeforeClass()
    {
        Config::$serverKey = getenv('SB-Mid-server-Jwsx-h06usFgv0B-UDFiAqnb');
        Config::$clientKey = getenv('SB-Mid-client-6gSQdoeYFDuygK5f');
        Config::$isProduction = false;
    }

    public function tearDown()
    {
        // One second interval to avoid throttle
        sleep(1);
    }
}
