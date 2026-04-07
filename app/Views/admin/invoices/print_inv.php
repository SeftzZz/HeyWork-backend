<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Invoice Print</title>
        <style>
            body{
                font-family: Arial, sans-serif;
                font-size:13px;
                color:#333;
                background:#fff;
            }

            .invoice-card{
                border:1px solid #ddd;
                padding:25px;
                max-width:900px;
                margin:auto;
            }

            .header-table{
                width:100%;
            }

            .company{
                font-size:22px;
                font-weight:bold;
            }

            .small{
                color:#666;
            }

            hr{
                margin:25px 0;
            }

            .summary-table td{
                padding:4px 0;
            }

            .items{
                width:100%;
                border-collapse:collapse;
                margin-top:20px;
            }

            .items th{
                background:#f5f5f5;
            }

            .items th,
            .items td{
                border:1px solid #ddd;
                padding:8px;
            }

            .total-table{
                margin-top:20px;
                width:300px;
                float:right;
            }

            .total-table td{
                padding:6px;
            }

            .total{
                font-weight:bold;
                font-size:14px;
            }

            .note{
                margin-top:40px;
                font-size:12px;
                color:#555;
            }

            .print-btn{
                margin-top:30px;
            }

            @media print{

                body{
                    margin:0;
                }

                .no-print{
                    display:none;
                }

                .invoice-card{
                    border:none;
                }

            }

        </style>

    </head>

    <body>

        <?php
            $year = substr($invoice['week_key'], 0, 4);
            $week = substr($invoice['week_key'], 4);
            $weekLabel = "Week " . $week . " / " . $year;

            $subtotalWorker = 0;
            $totalPlatformFee = 0;

            foreach ($items as $it) {
                $subtotalWorker += $it['worker_fee'];
                $totalPlatformFee += $it['platform_fee'];
            }

            $grandTotal = $subtotalWorker + $totalPlatformFee;
        ?>

        <div class="invoice-card">

            <!-- HEADER -->
            <table class="header-table">
                <tr>

                    <td width="60%">
                        <div class="company">Hey! Work</div>
                        <div class="small">Hospitality Workforce System</div>
                        <div class="small">Indonesia</div>
                        <div class="small">finance@heywork.id</div>
                    </td>

                    <td align="right">

                        <h2>
                            INVOICE #INV<?= str_pad($invoice['id'],6,'0',STR_PAD_LEFT) ?>
                        </h2>

                        <div>
                            Date Issued :
                            <strong>
                                <?= date('F d, Y', strtotime($invoice['created_at'])) ?>
                            </strong>
                        </div>

                        <div>
                            Status :
                            <strong>
                                <?= strtoupper($invoice['status']) ?>
                            </strong>
                        </div>

                    </td>

                </tr>
            </table>

            <hr>

            <!-- BILL SECTION -->
            <table width="100%">
                <tr>

                    <td width="50%">
                        <strong>Invoice To</strong><br>

                        <?= esc($invoice['hotel_name']) ?><br>
                        Hotel Finance Department<br>
                        <?= esc($invoice['hotel_email']) ?>
                    </td>

                    <td width="50%">

                        <strong>Bill Summary</strong>

                        <table class="summary-table">

                            <tr>
                                <td width="140">Invoice Period</td>
                                <td><?= $weekLabel ?></td>
                            </tr>

                            <tr>
                                <td>Total Workers</td>
                                <td><?= count($items) ?> Workers</td>
                            </tr>

                            <tr>
                                <td>Total Due</td>
                                <td>
                                    <strong>
                                        Rp<?= number_format($grandTotal,0,',','.') ?>
                                    </strong>
                                </td>
                            </tr>

                            <tr>
                                <td>Payment Method</td>
                                <td>Bank Transfer</td>
                            </tr>

                            <tr>
                                <td>Currency</td>
                                <td>IDR</td>
                            </tr>

                        </table>

                    </td>

                </tr>
            </table>

            <!-- ITEM TABLE -->

            <table class="items">

                <thead>
                    <tr>
                        <th>Worker</th>
                        <th>Position</th>
                        <th>Working Minutes</th>
                        <th>Worker Fee</th>
                        <th>Platform Fee</th>
                        <th>Total</th>
                    </tr>
                </thead>

                <tbody>

                    <?php foreach($items as $item): ?>

                        <tr>

                            <td><?= esc($item['worker_name']) ?></td>

                            <td><?= esc($item['position']) ?></td>

                            <td><?= $item['minutes'] ?> minutes</td>

                            <td>
                                Rp<?= number_format($item['worker_fee'],0,',','.') ?>
                            </td>

                            <td>
                                Rp<?= number_format($item['platform_fee'],0,',','.') ?>
                            </td>

                            <td>
                                Rp<?= number_format($item['worker_fee'] + $item['platform_fee'],0,',','.') ?>
                            </td>

                        </tr>

                    <?php endforeach ?>

                </tbody>

            </table>

            <!-- TOTAL -->

            <table class="total-table">

                <tr>
                    <td>Subtotal</td>
                    <td align="right">
                        Rp<?= number_format($subtotalWorker,0,',','.') ?>
                    </td>
                </tr>

                <tr>
                    <td>Platform Fee</td>
                    <td align="right">
                        Rp<?= number_format($totalPlatformFee,0,',','.') ?>
                    </td>
                </tr>

                <tr>
                    <td>Discount</td>
                    <td align="right">Rp0</td>
                </tr>

                <tr>
                    <td>Tax</td>
                    <td align="right">Rp0</td>
                </tr>

                <tr class="total">
                    <td>Total</td>
                    <td align="right">
                        Rp<?= number_format($grandTotal,0,',','.') ?>
                    </td>
                </tr>

            </table>

            <div style="clear:both"></div>

            <!-- NOTE -->

            <div class="note">

                <strong>Note :</strong><br>

                This invoice was generated automatically from the HeyWork workforce management system.

            </div>

            <!-- PRINT BUTTON -->

            <div class="print-btn no-print">

                <button onclick="window.print()">
                    Print Invoice
                </button>

            </div>

        </div>

        <script>
            window.onload = function(){
                window.print();
            }
        </script>
    </body>
</html>