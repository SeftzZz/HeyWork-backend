            <?= $this->extend('layouts/main') ?>
            <?= $this->section('content') ?>
            <?php
                $year = substr($invoice['week_key'], 0, 4);
                $week = substr($invoice['week_key'], 4);

                $weekLabel = "Week " . $week . " / " . $year;

                $statusClass = match ($invoice['status']) {
                    'paid' => 'bg-label-success',
                    'sent' => 'bg-label-info',
                    'partial' => 'bg-label-warning',
                    'overdue' => 'bg-label-danger',
                    default => 'bg-label-warning'
                };
            ?>
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <div class="row invoice-preview">
                        <!-- ================== INVOICE ================== -->
                        <div class="col-xl-9 col-md-8 col-12 mb-md-0 mb-4">
                            <div class="card invoice-preview-card">
                                <!-- HEADER -->
                                <div class="card-body">
                                    <div class="d-flex justify-content-between flex-xl-row flex-md-column flex-sm-row flex-column m-sm-3 m-0">
                                        <div class="mb-xl-0 mb-4">
                                            <div class="d-flex svg-illustration mb-4 gap-2 align-items-center">
                                                <span class="fw-bold fs-4">Hey Work</span>
                                            </div>
                                            <p class="mb-2">Hospitality Workforce System</p>
                                            <p class="mb-2">Indonesia</p>
                                            <p class="mb-0">finance@heywork.id</p>
                                        </div>

                                        <div>
                                            <h4 class="fw-medium mb-2">
                                                INVOICE #INV-<?= str_pad($invoice['id'], 6, '0', STR_PAD_LEFT) ?>
                                            </h4>
                                            <div class="mb-2 pt-1">
                                                <span>Date Issued:</span>
                                                <span class="fw-medium">
                                                    <?= date('F d, Y', strtotime($invoice['created_at'])) ?>
                                                </span>
                                            </div>
                                            <div class="pt-1">
                                                <span>Status:</span>
                                                <span class="badge <?= $statusClass ?>">
                                                    <?= strtoupper($invoice['status']) ?>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <hr class="my-0" />

                                <!-- BILL SECTION -->
                                <div class="card-body">
                                    <div class="row p-sm-3 p-0">
                                        <div class="col-xl-6 col-md-12 col-sm-5 col-12 mb-xl-0 mb-md-4 mb-sm-0 mb-4">
                                            <h6 class="mb-3">Invoice To:</h6>
                                            <p class="mb-1 fw-medium"><?= esc($invoice['hotel_name']) ?></p>
                                            <p class="mb-1">Hotel Finance Department</p>
                                            <p class="mb-0"><?= esc($invoice['hotel_email']) ?></p>
                                        </div>

                                        <div class="col-xl-6 col-md-12 col-sm-7 col-12">
                                            <h6 class="mb-4">Bill Summary:</h6>
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td class="pe-4">Invoice Period:</td>
                                                        <td><?= $weekLabel ?></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="pe-4">Total Workers:</td>
                                                        <td><?= count($items) ?> Workers</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="pe-4">Total Due:</td>
                                                        <td class="fw-medium">
                                                            Rp<?= number_format($invoice['total_amount'], 0, ',', '.') ?>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="pe-4">Payment Method:</td>
                                                        <td>Bank Transfer</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="pe-4">Currency:</td>
                                                        <td>IDR</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <!-- ITEM TABLE -->
                                <div class="table-responsive border-top">
                                    <table class="table m-0">
                                        <thead>
                                            <tr>
                                                <th>Worker</th>
                                                <th>Position</th>
                                                <th>Working Minutes</th>
                                                <th>Amount</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <?php foreach ($items as $item): ?>
                                                <tr>
                                                    <td><?= esc($item['worker_name']) ?></td>
                                                    <td><?= esc($item['position']) ?></td>
                                                    <td><?= $item['minutes'] ?> minutes</td>
                                                    <td>
                                                        Rp<?= number_format($item['amount'], 0, ',', '.') ?>
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>
                                            <tr>
                                                <td colspan="2" class="align-top px-4 py-4">
                                                    <p class="mb-2">
                                                        <span class="me-1 fw-medium">Generated By:</span>
                                                        <span>HeyWork System</span>
                                                    </p>

                                                    <span>
                                                        This invoice is automatically generated from worker attendance.
                                                    </span>
                                                </td>

                                                <td class="text-end pe-3 py-4">
                                                    <p class="mb-2 pt-3">Subtotal:</p>
                                                    <p class="mb-2">Discount:</p>
                                                    <p class="mb-2">Tax:</p>
                                                    <p class="mb-0 pb-3 fw-bold">Total:</p>
                                                </td>

                                                <td class="ps-2 py-4">
                                                    <p class="fw-medium mb-2 pt-3">
                                                        Rp<?= number_format($invoice['total_amount'], 0, ',', '.') ?>
                                                    </p>

                                                    <p class="fw-medium mb-2">Rp0</p>
                                                    <p class="fw-medium mb-2">Rp0</p>

                                                    <p class="fw-bold mb-0 pb-3">
                                                        Rp<?= number_format($invoice['total_amount'], 0, ',', '.') ?>
                                                    </p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- NOTE -->
                                <div class="card-body mx-3">
                                    <div class="row">
                                        <div class="col-12">
                                            <span class="fw-medium">Note:</span>
                                            <span>
                                                This invoice was generated automatically from the HeyWork workforce management system.
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- ================== ACTIONS ================== -->
                        <div class="col-xl-3 col-md-4 col-12 invoice-actions">
                            <div class="card">
                                <div class="card-body">
                                    <button
                                        class="btn btn-primary d-grid w-100 mb-2"
                                        data-bs-toggle="offcanvas"
                                        data-bs-target="#sendInvoiceOffcanvas">

                                        <span class="d-flex align-items-center justify-content-center text-nowrap">
                                            <i class="ti ti-send ti-xs me-2"></i>
                                            Send Invoice
                                        </span>
                                    </button>
                                    <a href="<?= base_url('admin/invoices/print/' . $invoice['id']) ?>"
                                       target="_blank"
                                       class="btn btn-primary w-100 mb-2">
                                        Print Invoice
                                    </a>

                                    <a href="<?= base_url('admin/invoices') ?>"
                                       class="btn btn-label-secondary d-grid w-100">
                                        Back
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <?= $this->endSection() ?>