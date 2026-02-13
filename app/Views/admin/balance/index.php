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
                                <!-- Earning Reports -->
                                <div class="col-lg-12 mb-4">
                                  <div class="card h-100">
                                    <div class="card-header pb-0 d-flex justify-content-between mb-lg-n4">
                                      <div class="card-title mb-0">
                                        <h5 class="mb-0">Earning Reports</h5>
                                        <small class="text-muted">Weekly Earnings Overview</small>
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
                                              <div class="badge rounded bg-label-primary p-1">
                                                <i class="ti ti-currency-dollar ti-sm"></i>
                                              </div>
                                              <h6 class="mb-0">Earnings</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 earning-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar"
                                                role="progressbar"
                                                style="width: 65%"
                                                aria-valuenow="65"
                                                aria-valuemin="0"
                                                aria-valuemax="100"></div>
                                            </div>
                                          </div>
                                          <div class="col-12 col-sm-4">
                                            <div class="d-flex gap-2 align-items-center">
                                              <div class="badge rounded bg-label-info p-1"><i class="ti ti-chart-pie-2 ti-sm"></i></div>
                                              <h6 class="mb-0">Profit</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 profit-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar bg-info"
                                                role="progressbar"
                                                style="width: 50%"
                                                aria-valuenow="50"
                                                aria-valuemin="0"
                                                aria-valuemax="100"></div>
                                            </div>
                                          </div>
                                          <div class="col-12 col-sm-4">
                                            <div class="d-flex gap-2 align-items-center">
                                              <div class="badge rounded bg-label-danger p-1">
                                                <i class="ti ti-brand-paypal ti-sm"></i>
                                              </div>
                                              <h6 class="mb-0">Expense</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 expense-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar bg-danger"
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
                                <!--/ Earning Reports -->

                                <!-- Total Earning -->
                                <div class="col-lg-6 mb-4">
                                  <div class="card">
                                    <div class="card-header d-flex justify-content-between pb-1">
                                      <h5 class="mb-0 card-title">Total Earning</h5>
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
                                            <h6 class="mb-0">Total Sales</h6>
                                            <small class="text-muted">Refund</small>
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
                                <!--/ Total Earning -->

                                <!-- Monthly Campaign State -->
                                <div class="col-lg-6 mb-4">
                                  <div class="card h-100">
                                    <div class="card-header d-flex justify-content-between">
                                      <div class="card-title mb-0">
                                        <h5 class="mb-0">Monthly Campaign State</h5>
                                        <small class="text-muted">8.52k Social Visiters</small>
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
                                <!--/ Monthly Campaign State -->
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

                              if (!res.status) return;

                              let credit = 0;
                              let debit  = 0;

                              let weeklyData = [0,0,0,0,0,0,0]; // Mo–Su

                              res.data.forEach(row => {

                                const amount = parseFloat(row.amount) || 0;
                                const date   = new Date(row.created_at);

                                let day = date.getDay(); // 0=Sun
                                day = (day === 0) ? 6 : day - 1; // Monday index 0

                                if (row.type === 'credit') {
                                  credit += amount;
                                  weeklyData[day] += amount;
                                }

                                if (row.type === 'debit') {
                                  debit += amount;
                                  weeklyData[day] -= amount;
                                }

                              });

                              const balance = credit - debit;
                              const percent = credit > 0 
                                  ? Math.round((balance / credit) * 100) 
                                  : 0;

                              const earnings = credit;
                              const expense  = debit;
                              const profit   = balance;

                              const totalFlow = earnings + expense;

                              // ==============================
                              // UPDATE EARNING REPORTS CARD
                              // ==============================

                              const earningCard = $('.card-title:contains("Earning Reports")')
                                                    .closest('.card');

                              earningCard.find('h1')
                                .text('Rp ' + balance.toLocaleString('id-ID'));

                              earningCard.find('.badge')
                                .text(percent + '%');

                              // update breakdown
                              earningCard.find('.earning-value')
                                .text('Rp ' + earnings.toLocaleString('id-ID'));

                              earningCard.find('.profit-value')
                                .text('Rp ' + profit.toLocaleString('id-ID'));

                              earningCard.find('.expense-value')
                                .text('Rp ' + expense.toLocaleString('id-ID'));

                              // progress %
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
                                .css('width', earningPercent + '%')
                                .attr('aria-valuenow', earningPercent);

                              earningCard.find('.profit-progress')
                                .css('width', profitPercent + '%')
                                .attr('aria-valuenow', profitPercent);

                              earningCard.find('.expense-progress')
                                .css('width', expensePercent + '%')
                                .attr('aria-valuenow', expensePercent);


                              // ==============================
                              // UPDATE TOTAL EARNING CARD
                              // ==============================

                              const totalCard = $('.card-title:contains("Total Earning")')
                                                  .closest('.card');

                              totalCard.find('h1')
                                .text(percent + '%');

                              totalCard.find('h6:contains("Total Sales")')
                                .closest('.d-flex')
                                .find('p')
                                .text('+Rp ' + earnings.toLocaleString('id-ID'));

                              totalCard.find('h6:contains("Total Revenue")')
                                .closest('.d-flex')
                                .find('p')
                                .text('+Rp ' + profit.toLocaleString('id-ID'));


                              // ==============================
                              // WEEKLY CHART
                              // ==============================

                              const weeklyEl = document.querySelector('#weeklyEarningReports');

                              if (weeklyEl) {

                                new ApexCharts(weeklyEl, {
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
                                  series: [{ data: weeklyData }],
                                  xaxis: {
                                    categories: ['Mo','Tu','We','Th','Fr','Sa','Su'],
                                    labels: { style: { colors: labelColor } }
                                  },
                                  yaxis: { labels: { show: false } },
                                  dataLabels: { enabled: false }
                                }).render();
                              }


                              // ==============================
                              // TOTAL STACKED CHART
                              // ==============================

                              const totalChartEl = document.querySelector('#totalEarningChart');

                              if (totalChartEl) {

                                new ApexCharts(totalChartEl, {
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
                                }).render();
                              }

                            }, 'json');

                            // ==============================
                            // MONTHLY CAMPAIGN STATE
                            // ==============================

                            $.get("<?= base_url('admin/balance/monthly-jobs') ?>", function(res){

                              if(!res.status) return;

                              const container = $('.card-title:contains("Monthly Campaign State")')
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

                          })();
                        </script>

                        <?= $this->endSection() ?>
