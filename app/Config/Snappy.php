<?php

namespace Config;

use Knp\Snappy\Pdf;

class Snappy
{
    public static function pdf()
    {
        return new Pdf('/usr/bin/wkhtmltopdf'); 
        // Windows:
        // return new Pdf('C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe');
    }
}