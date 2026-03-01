<!doctype html>
<html
    lang="en" class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
    dir="ltr" data-theme="theme-default"
    data-assets-path="../assets/" data-template="vertical-menu-template-no-customizer">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title><?= $title ?> | Hey! Work</title>

        <meta name="description" content="hey work connects hospitality professionals with trusted hotels for flexible daily and casual job opportunities." />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="<?= base_url('assets/img/favicon/favicon.png') ?>" />

        <!-- Fonts -->
        <!-- <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
            rel="stylesheet" /> -->

        <!-- Icons -->
        <link rel="stylesheet" href="<?= base_url('assets/vendor/fonts/fontawesome.css') ?>" />
        <link rel="stylesheet" href="<?= base_url('assets/vendor/fonts/tabler-icons.css') ?>" />
        <link rel="stylesheet" href="<?= base_url('assets/vendor/fonts/flag-icons.css') ?>" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="<?= base_url('assets/vendor/css/rtl/core.css') ?>" />
        <link rel="stylesheet" href="<?= base_url('assets/vendor/css/rtl/theme-default.css') ?>" />
        <link rel="stylesheet" href="<?= base_url('assets/css/demo.css') ?>" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/node-waves/node-waves.css') ?>" />
        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css') ?>" />
        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/typeahead-js/typeahead.css') ?>" />
        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/sweetalert2/sweetalert2.css') ?>" />
       
        <!-- Helpers -->
        <script src="<?= base_url('assets/vendor/js/helpers.js') ?>"></script>
        <script src="<?= base_url('assets/js/config.js') ?>"></script>

        <style>
          body {
              background: #fff !important;
              color: #000 !important;
              font-family: Arial, sans-serif !important;
          }
          .table,
          .table td,
          .table th {
              color: #000 !important;
          }
        </style>
    </head>

    <body>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Layout page -->
                <!-- <div class="layout-page"> -->
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="invoice-print p-3">

                          <div class="d-flex justify-content-between flex-row">
                            <div class="mb-4">
                              <h4 class="fw-bold"><?= esc($invoice['hotel_name']) ?></h4>
                              <p class="mb-1">Hotel Finance Department</p>
                              <p class="mb-1">Indonesia</p>
                              <p class="mb-0">finance@hotel.internal</p>
                            </div>

                            <div>
                              <h4 class="fw-medium">
                                INVOICE #INV-<?= str_pad($invoice['id'], 6, '0', STR_PAD_LEFT) ?>
                              </h4>
                              <div class="mb-2">
                                <span class="text-muted">Date Issued:</span>
                                <span class="fw-medium">
                                  <?= date('F d, Y', strtotime($invoice['created_at'])) ?>
                                </span>
                              </div>
                              <div>
                                <span class="text-muted">Currency:</span>
                                <span class="fw-medium">IDR</span>
                              </div>
                            </div>
                          </div>

                          <hr />

                          <div class="row d-flex justify-content-between mb-4">
                            <div class="col-sm-6 w-50">
                              <h6>Invoice To:</h6>
                              <p class="mb-1 fw-medium">HEYWORK</p>
                              <p class="mb-1">Hospitality Workforce System</p>
                              <p class="mb-0">support@heywork.id</p>
                            </div>

                            <div class="col-sm-6 w-50">
                              <h6>Bill Summary:</h6>
                              <table>
                                <tbody>
                                  <tr>
                                    <td class="pe-3">Total Claim:</td>
                                    <td class="fw-medium">
                                      Rp<?= number_format($invoice['amount'],0,',','.') ?>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td class="pe-3">Payment Method:</td>
                                    <td>Bank Transfer</td>
                                  </tr>
                                  <tr>
                                    <td class="pe-3">Status:</td>
                                    <td>UNBILLED</td>
                                  </tr>
                                </tbody>
                              </table>
                            </div>
                          </div>

                          <div class="table-responsive">
                            <table class="table m-0">
                              <thead class="table-light">
                                <tr>
                                  <th>Item</th>
                                  <th>Description</th>
                                  <th>Cost</th>
                                  <th>Total</th>
                                </tr>
                              </thead>
                              <tbody>

                                <tr>
                                    <td class="text-nowrap">Operational Expense</td>
                                    <td>
                                        <?= esc($invoice['description']) ?>
                                    </td>
                                    <td>
                                        Rp<?= number_format($invoice['amount'],0,',','.') ?>
                                    </td>
                                    <td>
                                        Rp<?= number_format($invoice['amount'],0,',','.') ?>
                                    </td>
                                </tr>

                            </tbody>
                            </table>
                            <table class="table m-0 table-striped">
                              
                              <tbody>
                                <tr>
                                  <td class="align-top px-4 py-3">
                                    <p class="mb-2">
                                      <span class="me-1 fw-medium">Generated By:</span>
                                      <span><?= esc($invoice['hotel_name']) ?></span>
                                    </p>
                                    <span>This invoice is submitted for reimbursement.</span>
                                  </td>
                                  <td class="text-end px-4 py-3">
                                    <p class="mb-2">Subtotal:</p>
                                    <p class="mb-2">Discount:</p>
                                    <p class="mb-2">Tax:</p>
                                    <p class="mb-0 fw-bold">Total:</p>
                                  </td>
                                  <td class="px-4 py-3">
                                    <p class="fw-medium mb-2">
                                      Rp<?= number_format($invoice['amount'],0,',','.') ?>
                                    </p>
                                    <p class="fw-medium mb-2">Rp0</p>
                                    <p class="fw-medium mb-2">Rp0</p>
                                    <p class="fw-bold mb-0">
                                      Rp<?= number_format($invoice['amount'],0,',','.') ?>
                                    </p>
                                  </td>
                                </tr>

                              </tbody>
                            </table>
                          </div>

                          <div class="row mt-4">
                            <div class="col-12">
                              <span class="fw-medium">Note:</span>
                              <span>
                                This invoice is generated automatically from debit transaction record in HeyWork system.
                              </span>
                            </div>
                          </div>

                        </div>

                        <script>
                          window.print();
                        </script>
                      <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->
                <!-- </div> -->
                <!-- / Layout page -->
            </div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>

            <!-- Drag Target Area To SlideIn Menu On Small Screens -->
            <div class="drag-target"></div>
        </div>
        <!-- / Layout wrapper -->

        <!-- Core JS -->
        <script src="<?= base_url('assets/vendor/libs/jquery/jquery.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/libs/popper/popper.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/js/bootstrap.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/libs/node-waves/node-waves.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/libs/hammer/hammer.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/libs/i18n/i18n.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/libs/typeahead-js/typeahead.js') ?>"></script>
        <script src="<?= base_url('assets/vendor/js/menu.js') ?>"></script>
        <!-- endbuild -->

        <!-- Main JS -->
        <script src="<?= base_url('assets/js/main.js') ?>"></script>

        <!-- Vendors JS -->
        <script src="<?= base_url('assets/vendor/libs/sweetalert2/sweetalert2new.js') ?>"></script>
        <?= $this->renderSection('scripts') ?>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
              let amountIndex = 0;
              const amountItems = document.querySelectorAll('#amount-rotator .amount-item');

              if (!amountItems.length) return;

              setInterval(() => {
                amountItems[amountIndex].classList.remove('active');
                amountIndex = (amountIndex + 1) % amountItems.length;
                amountItems[amountIndex].classList.add('active');
              }, 5000);
            });
        </script>

        <!-- Page JS -->
    </body>
</html>