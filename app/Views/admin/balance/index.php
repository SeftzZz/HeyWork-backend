                        <?= $this->extend('layouts/main') ?>
                        <?= $this->section('content') ?>
                            <style>
                            /* tanggal sebelum hari ini */
                            .fc-day-past {
                              background-color: #f5f5f5;
                              cursor: not-allowed;
                              opacity: 0.6;
                            }

                            /* cegah hover */
                            .fc-day-past:hover {
                              background-color: #f5f5f5;
                            }
                            </style>

                            <div class="container-xxl flex-grow-1 container-p-y">
                              <div class="row">
                                <!-- Productivity Ratio -->
                                <div class="col-lg-12 mb-4">
                                  <div class="card h-100">
                                    <div class="card-header pb-0 d-flex justify-content-between mb-lg-n4">
                                      <div class="card-title mb-0">
                                        <h5 class="mb-0">Productivity Ratio</h5>
                                        <small class="badge rounded bg-label-success">Weekly Earnings Overview</small>
                                      </div>
                                      <div class="dropdown">
                                        <button
                                          class="btn p-0"
                                          type="button"
                                          id="earningReportsId"
                                          data-bs-toggle="dropdown"
                                          aria-haspopup="true"
                                          aria-expanded="false">
                                          <i class="ti ti-dots-vertical ti-sm text-muted"></i>
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="earningReportsId">
                                          <a class="dropdown-item" href="javascript:void(0);">View More</a>
                                          <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                                        </div>
                                      </div>
                                      <!-- </div> -->
                                    </div>
                                    <div class="card-body">
                                      <div class="row">
                                        <div class="col-12 col-md-4 d-flex flex-column align-self-end">
                                          <div class="d-flex gap-2 align-items-center mb-2 pb-1 flex-wrap">
                                            <h1 class="mb-0">0</h1>
                                            <div class="badge rounded bg-label-success">+4.2%</div>
                                          </div>
                                          <small>You informed of this week compared to last week</small>
                                        </div>
                                        <div class="col-12 col-md-8">
                                          <div id="weeklyEarningReports"></div>
                                        </div>
                                      </div>
                                      <div class="border rounded p-3 mt-4">
                                        <div class="row gap-4 gap-sm-0">
                                          <div class="col-12 col-sm-4">
                                            <div class="d-flex gap-2 align-items-center">
                                              <h6 class="mb-0">Month To Date</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 earning-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar earning-progress"
                                                role="progressbar"
                                                style="width: 65%"
                                                aria-valuenow="65"
                                                aria-valuemin="0"
                                                aria-valuemax="100"></div>
                                            </div>
                                          </div>
                                          <div class="col-12 col-sm-4">
                                            <div class="d-flex gap-2 align-items-center">
                                              <h6 class="mb-0">Profit</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 profit-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar bg-info profit-progress"
                                                role="progressbar"
                                                style="width: 50%"
                                                aria-valuenow="50"
                                                aria-valuemin="0"
                                                aria-valuemax="100"></div>
                                            </div>
                                          </div>
                                          <div class="col-12 col-sm-4">
                                            <div class="d-flex gap-2 align-items-center">
                                              <h6 class="mb-0">Expense</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 expense-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar bg-danger expense-progress"
                                                role="progressbar"
                                                style="width: 65%"
                                                aria-valuenow="65"
                                                aria-valuemin="0"
                                                aria-valuemax="100"></div>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <!--/ Productivity Ratio -->

                                <!-- Monthly Growth -->
                                <div class="col-lg-6 mb-4">
                                  <div class="card">
                                    <div class="card-header d-flex justify-content-between pb-1">
                                      <h5 class="mb-0 card-title">Monthly Growth</h5>
                                      <div class="dropdown">
                                        <button
                                          class="btn p-0"
                                          type="button"
                                          id="totalEarning"
                                          data-bs-toggle="dropdown"
                                          aria-haspopup="true"
                                          aria-expanded="false">
                                          <i class="ti ti-dots-vertical ti-sm text-muted"></i>
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="totalEarning">
                                          <a class="dropdown-item" href="javascript:void(0);">View More</a>
                                          <a class="dropdown-item" href="javascript:void(0);">Delete</a>
                                        </div>
                                      </div>
                                    </div>
                                    <div class="card-body">
                                      <div class="d-flex align-items-center">
                                        <h1 class="mb-0 me-2">87%</h1>
                                        <i class="ti ti-chevron-up text-success me-1"></i>
                                        <p class="text-success mb-0">25.8%</p>
                                      </div>
                                      <div id="totalEarningChart"></div>
                                      <div class="d-flex align-items-start my-4">
                                        <div class="badge rounded bg-label-primary p-2 me-3 rounded">
                                          <i class="ti ti-currency-dollar ti-sm"></i>
                                        </div>
                                        <div class="d-flex justify-content-between w-100 gap-2 align-items-center">
                                          <div class="me-2">
                                            <h6 class="mb-0">Total DW Cost</h6>
                                            <small class="text-muted">Cost</small>
                                          </div>
                                          <p class="mb-0 text-success">+$98</p>
                                        </div>
                                      </div>
                                      <div class="d-flex align-items-start">
                                        <div class="badge rounded bg-label-secondary p-2 me-3 rounded">
                                          <i class="ti ti-brand-paypal ti-sm"></i>
                                        </div>
                                        <div class="d-flex justify-content-between w-100 gap-2 align-items-center">
                                          <div class="me-2">
                                            <h6 class="mb-0">Total Revenue</h6>
                                            <small class="text-muted">Client Payment</small>
                                          </div>
                                          <p class="mb-0 text-success">+$126</p>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <!--/ Monthly Growth -->

                                <!-- Departement -->
                                <div class="col-lg-6 mb-4">
                                  <div class="card h-100">
                                    <div class="card-header d-flex justify-content-between">
                                      <div class="card-title mb-0">
                                        <h5 class="mb-0">Departement</h5>
                                        <small class="text-muted">8.52k Daily Worker</small>
                                      </div>
                                      <div class="dropdown">
                                        <button
                                          class="btn p-0"
                                          type="button"
                                          id="MonthlyCampaign"
                                          data-bs-toggle="dropdown"
                                          aria-haspopup="true"
                                          aria-expanded="false">
                                          <i class="ti ti-dots-vertical ti-sm text-muted"></i>
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-end" aria-labelledby="MonthlyCampaign">
                                          <a class="dropdown-item" href="javascript:void(0);">Refresh</a>
                                          <a class="dropdown-item" href="javascript:void(0);">Download</a>
                                          <a class="dropdown-item" href="javascript:void(0);">View All</a>
                                        </div>
                                      </div>
                                    </div>
                                    <div class="card-body">
                                      <ul class="p-0 m-0">
                                        <li class="mb-4 pb-1 d-flex justify-content-between align-items-center">
                                          <div class="badge bg-label-success rounded p-2"><i class="ti ti-mail ti-sm"></i></div>
                                          <div class="d-flex justify-content-between w-100 flex-wrap">
                                            <h6 class="mb-0 ms-3">Emails</h6>
                                            <div class="d-flex">
                                              <p class="mb-0 fw-medium">12,346</p>
                                              <p class="ms-3 text-success mb-0">0.3%</p>
                                            </div>
                                          </div>
                                        </li>
                                        <li class="mb-4 pb-1 d-flex justify-content-between align-items-center">
                                          <div class="badge bg-label-info rounded p-2"><i class="ti ti-link ti-sm"></i></div>
                                          <div class="d-flex justify-content-between w-100 flex-wrap">
                                            <h6 class="mb-0 ms-3">Opened</h6>
                                            <div class="d-flex">
                                              <p class="mb-0 fw-medium">8,734</p>
                                              <p class="ms-3 text-success mb-0">2.1%</p>
                                            </div>
                                          </div>
                                        </li>
                                        <li class="mb-4 pb-1 d-flex justify-content-between align-items-center">
                                          <div class="badge bg-label-warning rounded p-2"><i class="ti ti-click ti-sm"></i></div>
                                          <div class="d-flex justify-content-between w-100 flex-wrap">
                                            <h6 class="mb-0 ms-3">Clicked</h6>
                                            <div class="d-flex">
                                              <p class="mb-0 fw-medium">967</p>
                                              <p class="ms-3 text-success mb-0">1.4%</p>
                                            </div>
                                          </div>
                                        </li>
                                        <li class="mb-4 pb-1 d-flex justify-content-between align-items-center">
                                          <div class="badge bg-label-primary rounded p-2"><i class="ti ti-users ti-sm"></i></div>
                                          <div class="d-flex justify-content-between w-100 flex-wrap">
                                            <h6 class="mb-0 ms-3">Subscribe</h6>
                                            <div class="d-flex">
                                              <p class="mb-0 fw-medium">345</p>
                                              <p class="ms-3 text-success mb-0">8.5k</p>
                                            </div>
                                          </div>
                                        </li>
                                        <li class="mb-4 pb-1 d-flex justify-content-between align-items-center">
                                          <div class="badge bg-label-secondary rounded p-2">
                                            <i class="ti ti-alert-triangle ti-sm text-body"></i>
                                          </div>
                                          <div class="d-flex justify-content-between w-100 flex-wrap">
                                            <h6 class="mb-0 ms-3">Complaints</h6>
                                            <div class="d-flex">
                                              <p class="mb-0 fw-medium">10</p>
                                              <p class="ms-3 text-success mb-0">1.5%</p>
                                            </div>
                                          </div>
                                        </li>
                                        <li class="d-flex justify-content-between align-items-center">
                                          <div class="badge bg-label-danger rounded p-2"><i class="ti ti-ban ti-sm"></i></div>
                                          <div class="d-flex justify-content-between w-100 flex-wrap">
                                            <h6 class="mb-0 ms-3">Unsubscribe</h6>
                                            <div class="d-flex">
                                              <p class="mb-0 fw-medium">86</p>
                                              <p class="ms-3 text-success mb-0">0.8%</p>
                                            </div>
                                          </div>
                                        </li>
                                      </ul>
                                    </div>
                                  </div>
                                </div>
                                <!--/ Departement -->
                              </div>
                            </div>
                        <?= $this->endSection() ?>
                        
                        <?= $this->section('scripts') ?>

                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/node-waves/node-waves.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/typeahead-js/typeahead.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/toastr/toastr.css') ?>">
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/apex-charts/apex-charts.css') ?>" />

                        <script src="<?= base_url('assets/vendor/libs/apex-charts/apexcharts.js') ?>"></script>
                        <!-- <script src="<?= base_url('assets/js/dashboards-analytics.js') ?>"></script> -->
                        <script>
                          'use strict';

                          (function () {

                            let cardColor, headingColor, labelColor, shadeColor, grayColor;

                            if (isDarkStyle) {
                              cardColor = config.colors_dark.cardColor;
                              labelColor = config.colors_dark.textMuted;
                              headingColor = config.colors_dark.headingColor;
                              shadeColor = 'dark';
                              grayColor = '#5E6692';
                            } else {
                              cardColor = config.colors.cardColor;
                              labelColor = config.colors.textMuted;
                              headingColor = config.colors.headingColor;
                              shadeColor = '';
                              grayColor = '#817D8D';
                            }

                            function formatRupiahShort(number) {
                              if (number >= 1_000_000_000_000) {
                                return (number / 1_000_000_000_000).toFixed(1).replace('.0','') + 'T';
                              }
                              if (number >= 1_000_000_000) {
                                return (number / 1_000_000_000).toFixed(1).replace('.0','') + 'M';
                              }
                              if (number >= 1_000_000) {
                                return (number / 1_000_000).toFixed(1).replace('.0','') + 'Jt';
                              }
                              if (number >= 1_000) {
                                return (number / 1_000).toFixed(1).replace('.0','') + 'Rb';
                              }
                              return number.toString();
                            }

                            // ==============================
                            // FETCH BALANCE DATA
                            // ==============================
                            $.get("<?= base_url('admin/balance/history') ?>", function(res) {

                              if (!res || !res.status || !Array.isArray(res.data)) {
                                console.log('Balance data invalid');
                                return;
                              }

                              const earningCard = $('.card-title:contains("Productivity Ratio")')
                                                    .closest('.card');

                              const infoText = earningCard.find('small');
                              const badge    = earningCard.find('.badge');

                              // =========================
                              // INITIAL VALUE
                              // =========================
                              let balanceCredit = 0;
                              let balanceDebit  = 0;
                              let earnings = 0;
                              let expense  = 0;

                              let weeklyRevenue = [0,0,0,0,0,0,0];
                              let weeklyExpense = [0,0,0,0,0,0,0];
                              let todayRevenue = 0;
                              let todayExpense = 0;

                              // =========================
                              // MAIN LOOP
                              // =========================
                              res.data.forEach(row => {

                                const amount = parseFloat(row.amount) || 0;
                                if (!row.created_at) return;

                                const date = new Date(row.created_at);
                                if (isNaN(date)) return;

                                let day = date.getDay();
                                day = (day === 0) ? 6 : day - 1;

                                // =========================
                                // TODAY DATE
                                // =========================
                                const today = new Date();
                                const todayDateStr =
                                  today.getFullYear() + '-' +
                                  String(today.getMonth() + 1).padStart(2, '0') + '-' +
                                  String(today.getDate()).padStart(2, '0');

                                const rowDateStr =
                                  date.getFullYear() + '-' +
                                  String(date.getMonth() + 1).padStart(2, '0') + '-' +
                                  String(date.getDate()).padStart(2, '0');

                                // =========================
                                // BALANCE (lifetime)
                                // =========================
                                if (row.type === 'credit') balanceCredit += amount;
                                if (row.type === 'debit')  balanceDebit  += amount;

                                // =========================
                                // TOTAL (untuk earning/profit chart)
                                // =========================
                                if (row.category === 'revenue') {
                                  earnings += amount;
                                  weeklyRevenue[day] += amount;
                                }

                                if (row.category === 'payroll' || row.category === 'extend') {
                                  expense += amount;
                                  weeklyExpense[day] += amount;
                                }

                                // =========================
                                // TODAY ONLY (angka besar atas)
                                // =========================
                                if (rowDateStr === todayDateStr) {

                                  if (row.category === 'revenue') {
                                    todayRevenue = amount; // bukan +=
                                  }

                                  if (row.category === 'payroll' || row.category === 'extend') {
                                    todayExpense += amount;
                                  }

                                }

                              });

                              // =========================
                              // REVENUE GROWTH
                              // =========================
                              let revenueByDate = {};

                              // group revenue per date
                              res.data.forEach(row => {

                                if (row.category === 'revenue' && row.created_at) {

                                  const date = new Date(row.created_at);

                                  const key =
                                    date.getFullYear() + '-' +
                                    String(date.getMonth() + 1).padStart(2, '0') + '-' +
                                    String(date.getDate()).padStart(2, '0');

                                  if (!revenueByDate[key]) revenueByDate[key] = 0;

                                  revenueByDate[key] += parseFloat(row.amount) || 0;
                                }
                              });

                              // ambil 2 hari terakhir
                              const sortedDates = Object.keys(revenueByDate).sort().reverse();

                              let growthPercent = 0;
                              let isGrowthUp = true;

                              if (sortedDates.length >= 2) {

                                const currentRevenue = revenueByDate[sortedDates[0]];
                                const lastRevenue    = revenueByDate[sortedDates[1]];

                                if (lastRevenue > 0) {
                                  growthPercent = ((currentRevenue - lastRevenue) / lastRevenue) * 100;
                                  isGrowthUp = growthPercent >= 0;
                                }
                              }

                              let secondaryPercent = 0;

                              if (sortedDates.length >= 3) {

                                const prevRevenue     = revenueByDate[sortedDates[1]];
                                const prevPrevRevenue = revenueByDate[sortedDates[2]];

                                if (prevPrevRevenue > 0) {
                                  secondaryPercent = ((prevRevenue - prevPrevRevenue) / prevPrevRevenue) * 100;
                                }
                              }

                              const secondaryRounded = Math.abs(secondaryPercent).toFixed(2);
                              const isSecondaryUp = secondaryPercent >= 0;


                              const growthRounded = Math.abs(growthPercent).toFixed(2);

                              // =========================
                              // UPDATE Monthly Growth CARD
                              // =========================

                              const totalCard = $('.card-title:contains("Monthly Growth")')
                                                  .closest('.card');

                              // ===== MAIN GROWTH (h1) =====
                              totalCard.find('.d-flex.align-items-center h1')
                                .text(growthRounded + '%');

                              // ===== ARROW ICON =====
                              const arrowIcon = totalCard.find('.d-flex.align-items-center i.ti');
                              const percentText = totalCard.find('.d-flex.align-items-center p');

                              // ===== MAIN ARROW =====
                              if (isGrowthUp) {
                                arrowIcon.removeClass('ti-chevron-down text-danger')
                                         .addClass('ti-chevron-up text-success');
                              } else {
                                arrowIcon.removeClass('ti-chevron-up text-success')
                                         .addClass('ti-chevron-down text-danger');
                              }

                              // ===== SECONDARY PERCENT (history sebelumnya) =====
                              percentText
                                .text(secondaryRounded + '%')
                                .removeClass('text-success text-danger')
                                .addClass(isSecondaryUp ? 'text-success' : 'text-danger');

                              // ===== Total DW Cost (Expense) =====
                              totalCard.find('h6:contains("Total DW Cost")')
                                .closest('.d-flex')
                                .find('p')
                                .text('-Rp ' + expense.toLocaleString('id-ID'))
                                .removeClass('text-success')
                                .addClass('text-danger');

                              // ===== Total Revenue (Earnings) =====
                              totalCard.find('h6:contains("Total Revenue")')
                                .closest('.d-flex')
                                .find('p')
                                .text('+Rp ' + earnings.toLocaleString('id-ID'))
                                .removeClass('text-danger')
                                .addClass('text-success');


                              // =========================
                              // LAST REVENUE DATE
                              // =========================
                              let lastRevenueDate = null;

                              res.data.forEach(row => {
                                if (row.category === 'revenue' && row.created_at) {
                                  const date = new Date(row.created_at);
                                  if (!isNaN(date)) {
                                    if (!lastRevenueDate || date > lastRevenueDate) {
                                      lastRevenueDate = date;
                                    }
                                  }
                                }
                              });

                              if (lastRevenueDate) {

                                const day   = lastRevenueDate.toLocaleDateString('id-ID', {
                                  day: '2-digit',
                                  month: 'short',
                                  year: 'numeric'
                                });

                                const time  = lastRevenueDate.toLocaleTimeString('id-ID', {
                                  hour: '2-digit',
                                  minute: '2-digit',
                                  hour12: false
                                });

                                infoText.text('Last today revenue update: ' + day + ' - ' + time + ' WIB');

                              } else {
                                infoText.text('No revenue recorded yet');
                              }

                              // =========================
                              // CALCULATION
                              // =========================
                              const balance = balanceCredit - balanceDebit;
                              const profit  = earnings - expense;
                              const totalFlow = earnings + expense;

                              const dwRatio = todayRevenue > 0
                                ? (todayExpense / todayRevenue) * 100
                                : 0;
                              const dwRounded = dwRatio.toFixed(2);

                              // =========================
                              // UPDATE CARD
                              // =========================
                              const todayNet = todayRevenue - todayExpense;

                              earningCard.find('h1').html(`
                                <span id="editableRevenue" style="cursor:pointer">
                                  Rp ${todayRevenue.toLocaleString('id-ID')}
                                </span>
                              `);

                              badge.text(dwRounded + '%');
                              badge.removeClass('bg-label-success bg-label-warning bg-label-danger bg-label-info');

                              let ratioLabel = '';
                              let ratioClass = '';

                              if (dwRatio >= 6 && dwRatio <= 10) {
                                ratioLabel = 'GOOD';
                                ratioClass = 'text-success';
                                badge.addClass('bg-label-success');
                              } 
                              else if (dwRatio > 10 && dwRatio <= 12) {
                                ratioLabel = 'AVERAGE';
                                ratioClass = 'text-warning';
                                badge.addClass('bg-label-warning');
                              } 
                              else if (dwRatio > 12 && dwRatio <= 15) {
                                ratioLabel = 'BAD';
                                ratioClass = 'text-danger';
                                badge.addClass('bg-label-danger');
                              } 
                              else if (dwRatio > 15) {
                                ratioLabel = 'NOT OPTIMAL MAN POWER';
                                ratioClass = 'text-danger';
                                badge.addClass('bg-label-danger');
                              } 
                              else {
                                ratioLabel = 'UNDER TARGET';
                                ratioClass = 'text-info';
                                badge.addClass('bg-label-info');
                              }

                              earningCard.find('.earning-value')
                                .text('Rp ' + earnings.toLocaleString('id-ID'));

                              earningCard.find('.profit-value')
                                .text('Rp ' + profit.toLocaleString('id-ID'));

                              earningCard.find('.expense-value')
                                .text('Rp ' + expense.toLocaleString('id-ID'));

                              earningCard.find('.card-title small')
                                .removeClass('text-muted text-success text-warning text-danger text-info')
                                .addClass(ratioClass)
                                .text(ratioLabel);

                              // =========================
                              // PROGRESS BAR
                              // =========================
                              const earningPercent = totalFlow > 0 
                                ? Math.round((earnings / totalFlow) * 100) 
                                : 0;

                              const profitPercent = earnings > 0 
                                ? Math.round((profit / earnings) * 100) 
                                : 0;

                              const expensePercent = totalFlow > 0 
                                ? Math.round((expense / totalFlow) * 100) 
                                : 0;

                              earningCard.find('.earning-progress')
                                .css('width', earningPercent + '%');

                              earningCard.find('.profit-progress')
                                .css('width', profitPercent + '%');

                              earningCard.find('.expense-progress')
                                .css('width', expensePercent + '%');

                              // =========================
                              // WEEKLY CHART (SAFE)
                              // =========================
                              const weeklyEl = document.querySelector('#weeklyEarningReports');

                              if (weeklyEl) {

                                if (window.weeklyChartInstance) {
                                  window.weeklyChartInstance.destroy();
                                }

                                window.weeklyChartInstance = new ApexCharts(weeklyEl, {
                                  chart: {
                                    height: 202,
                                    type: 'bar',
                                    toolbar: { show: false }
                                  },
                                  plotOptions: {
                                    bar: {
                                      columnWidth: '38%',
                                      borderRadius: 4,
                                      distributed: true
                                    }
                                  },
                                  grid: { show: false },
                                  colors: [
                                    config.colors_label.primary,
                                    config.colors_label.primary,
                                    config.colors_label.primary,
                                    config.colors_label.primary,
                                    config.colors.primary,
                                    config.colors_label.primary,
                                    config.colors_label.primary
                                  ],
                                  series: [{
                                    data: weeklyRevenue.map((val, i) => val - (weeklyExpense[i] || 0))
                                  }],
                                  xaxis: {
                                    categories: ['Mo','Tu','We','Th','Fr','Sa','Su'],
                                    labels: { style: { colors: labelColor } }
                                  },
                                  yaxis: { labels: { show: false } },
                                  dataLabels: { enabled: false }
                                });

                                window.weeklyChartInstance.render();
                              }

                              // =========================
                              // TOTAL STACKED CHART
                              // =========================
                              const totalChartEl = document.querySelector('#totalEarningChart');

                              if (totalChartEl) {

                                if (window.totalChartInstance) {
                                  window.totalChartInstance.destroy();
                                }

                                window.totalChartInstance = new ApexCharts(totalChartEl, {
                                  series: [
                                    { name: 'Credit', data: [earnings] },
                                    { name: 'Debit',  data: [-expense] }
                                  ],
                                  chart: {
                                    height: 230,
                                    stacked: true,
                                    type: 'bar',
                                    toolbar: { show: false }
                                  },
                                  plotOptions: {
                                    bar: {
                                      columnWidth: '30%',
                                      borderRadius: 6
                                    }
                                  },
                                  colors: [config.colors.primary, grayColor],
                                  tooltip: {
                                    y: {
                                      formatter: val =>
                                        'Rp ' + Math.abs(val).toLocaleString('id-ID')
                                    }
                                  },
                                  xaxis: {
                                    categories: ['Total'],
                                    labels: { show: false }
                                  },
                                  yaxis: { labels: { show: false } },
                                  dataLabels: { enabled: false },
                                  legend: { show: false },
                                  grid: { show: false }
                                });

                                window.totalChartInstance.render();
                              }
                            }, 'json');

                            // ==============================
                            // Departement
                            // ==============================
                            $.get("<?= base_url('admin/balance/monthly-jobs') ?>", function(res){

                              if(!res.status) return;

                              const container = $('.card-title:contains("Departement")')
                                                .closest('.card')
                                                .find('ul');

                              container.html('');

                              let total = 0;
                              res.data.forEach(row => total += parseInt(row.total_applications));

                              res.data.forEach(row => {

                                const percent = total > 0
                                    ? Math.round((row.total_applications / total) * 100)
                                    : 0;

                                container.append(`
                                  <li class="mb-4 pb-1 d-flex justify-content-between align-items-center">
                                    <div class="badge bg-label-primary rounded p-2">
                                      <i class="ti ti-briefcase ti-sm"></i>
                                    </div>
                                    <div class="d-flex justify-content-between w-100 flex-wrap">
                                      <h6 class="mb-0 ms-3">${row.position}</h6>
                                      <div class="d-flex">
                                        <p class="mb-0 fw-medium">${row.total_applications}</p>
                                        <p class="ms-3 text-success mb-0">${percent}%</p>
                                      </div>
                                    </div>
                                  </li>
                                `);
                              });
                            }, 'json');

                            $(document).on('click', '#editableRevenue', function(){

                                const current = $(this).text().replace(/[^0-9]/g,'');

                                const input = `
                                    <input type="number" 
                                           id="revenueInput" 
                                           class="form-control"
                                           value="${current}" />
                                    <button class="btn btn-sm btn-primary mt-2" id="saveRevenue">
                                        Save
                                    </button>
                                `;

                                $(this).parent().html(input);
                            });

                            $(document).on('click', '#saveRevenue', function(){

                                const amount = $('#revenueInput').val();

                                $.post("<?= base_url('admin/balance/update-revenue') ?>", {
                                    revenue: amount,
                                    '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
                                }, function(res){

                                    if(!res.status){
                                        alert(res.message);
                                        return;
                                    }

                                    location.reload();

                                }, 'json');
                            });

                          })();
                        </script>

                        <?= $this->endSection() ?>
