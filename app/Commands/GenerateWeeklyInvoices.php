<?php

namespace App\Commands;

use CodeIgniter\CLI\BaseCommand;
use CodeIgniter\CLI\CLI;
use App\Services\InvoiceService;

class GenerateWeeklyInvoices extends BaseCommand
{
    protected $group       = 'Invoices';
    protected $name        = 'invoice:generate-weekly-inv';
    protected $description = 'Generate invoices for all hotels';

    public function run(array $params)
    {
        $db = \Config\Database::connect();

        $weekKey = date('oW', strtotime('-3 week'));

        CLI::write("Generate Invoice Week: ".$weekKey,'yellow');

        $hotels = $db->table('hotels')
            ->select('id')
            ->get()
            ->getResultArray();

        $service = new InvoiceService();

        foreach ($hotels as $hotel) {
            $service->generateWeeklyInv($weekKey,$hotel['id']);
            CLI::write("Hotel ".$hotel['id']." processed",'green');
        }
         CLI::write("Done.","green");
    }
}