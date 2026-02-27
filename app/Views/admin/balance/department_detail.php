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

                            .nav-align-top > .nav-pills ~ .tab-content, .nav-align-right > .nav-pills ~ .tab-content, .nav-align-bottom > .nav-pills ~ .tab-content, .nav-align-left > .nav-pills ~ .tab-content {
                                box-shadow: none;
                            }

                            .nav-align-top > .tab-content, .nav-align-right > .tab-content, .nav-align-bottom > .tab-content, .nav-align-left > .tab-content {
                                flex-shrink: 1;
                                background-clip: padding-box;
                                background: transparent;
                            }

                            .tab-content {
                                 padding: 0rem; 
                                border-radius: 0.375rem;
                            }
                            </style>

                            <div class="container-xxl flex-grow-1 container-p-y">
                              <div class="card">
                                <div class="card-header">
                                  <h5>Department Detail</h5>
                                </div>
                                <div class="card-body">

                                  <table id="departmentDetailTable" class="table table-bordered table-striped text-center">
                                    <thead class="table-light">
                                      <tr>
                                        <th rowspan="2" class="text-start">Nama</th>
                                        <th colspan="3" id="detailDateHeader">-</th>
                                      </tr>
                                      <tr>
                                        <th>Posisi</th>
                                        <th>Gaji</th>
                                        <th>Cost</th>
                                      </tr>
                                    </thead>
                                    <tbody id="departmentDetailBody"></tbody>
                                  </table>
                                </div>
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
                          $(document).ready(function(){

                            const urlParams = new URLSearchParams(window.location.search);
                            const department = urlParams.get('department');
                            const type       = urlParams.get('type');
                            const date       = urlParams.get('date');

                            $.get("<?= base_url('admin/balance/department-detail-data') ?>", {
                              department: department,
                              type: type,
                              date: date,
                            }, function(res){

                              if(!res.status) return;

                              const tbody = $('#departmentDetailBody');

                              const todayLabelClass = getRatioBadgeClass(res.today_label);
                              const mtdLabelClass   = getRatioBadgeClass(res.mtd_label);

                              const formattedDate = new Date(res.date).toLocaleDateString('id-ID', {
                                day: '2-digit',
                                month: 'short',
                                year: '2-digit'
                              });

                              // ======================
                              // REVENUE MULTIPLE
                              // ======================
                              const todayMultiple = res.total_cost > 0 
                                ? (res.today_revenue / res.total_cost) 
                                : 0;

                              const mtdMultiple = res.mtd_cost > 0 
                                ? (res.mtd_revenue / res.mtd_cost) 
                                : 0;
                                
                              function getMultipleStatus(value) {
                                if (value <= 7) {
                                  return {
                                    label: 'OVER',
                                    class: 'bg-label-danger'
                                  };
                                }

                                if (value <= 14) {
                                  return {
                                    label: 'AVERAGE',
                                    class: 'bg-label-warning'
                                  };
                                }

                                return {
                                  label: 'GOOD',
                                  class: 'bg-label-success'
                                };
                              }

                              const todayMultipleStatus = getMultipleStatus(todayMultiple);
                              const mtdMultipleStatus   = getMultipleStatus(mtdMultiple);

                              $('#detailDateHeader').text(formattedDate);

                              tbody.html('');

                              // ======================
                              // DETAIL PER USER
                              // ======================
                              res.data.forEach(row => {

                                tbody.append(`
                                  <tr>
                                    <td class="text-start fw-semibold text-primary">
                                      ${row.name}
                                    </td>
                                    <td>${row.position}</td>
                                    <td>${row.salary.toLocaleString('id-ID')}</td>
                                    <td>${row.cost.toLocaleString('id-ID')}</td>
                                  </tr>
                                `);

                              });

                              // Spacer
                              tbody.append(`<tr><td colspan="4"></td></tr>`);

                              // Total Cost
                              tbody.append(`
                                <tr class="table-secondary fw-bold">
                                  <td class="text-start">Total Cost</td>
                                  <td></td>
                                  <td></td>
                                  <td>${res.total_cost.toLocaleString('id-ID')}</td>
                                </tr>
                              `);

                              // ======================
                              // TOTAL COST MTD
                              // ======================
                              tbody.append(`
                                <tr class="table-secondary fw-bold">
                                  <td class="text-start">Total Cost (Month To Date)</td>
                                  <td></td>
                                  <td></td>
                                  <td>${res.mtd_cost.toLocaleString('id-ID')}</td>
                                </tr>
                              `);

                              // ======================
                              // TODAY
                              // ======================
                              tbody.append(`
                                <tr class="fw-bold">
                                  <td rowspan="2" class="text-start">Today</td>
                                  <td>Revenue</td>
                                  <td></td>
                                  <td>${res.today_revenue.toLocaleString('id-ID')}</td>
                                </tr>
                                <tr>
                                  <td>Rasio</td>
                                  <td>${res.today_ratio}%</td>
                                  <td>
                                    <span class="badge ${todayLabelClass}">
                                      ${res.today_label}
                                    </span>
                                  </td>
                                </tr>
                              `);

                              // ======================
                              // MTD
                              // ======================
                              tbody.append(`
                                <tr class="fw-bold">
                                  <td rowspan="2" class="text-start">Month To Date</td>
                                  <td>Revenue</td>
                                  <td></td>
                                  <td>${res.mtd_revenue.toLocaleString('id-ID')}</td>
                                </tr>
                                <tr>
                                  <td>Rasio</td>
                                  <td>${res.mtd_ratio}%</td>
                                  <td>
                                    <span class="badge ${mtdLabelClass}">
                                      ${res.mtd_label}
                                    </span>
                                  </td>
                                </tr>
                              `);

                              // SALES & MARKETING
                              // Spacer
                              // tbody.append(`<tr><td colspan="4"></td></tr>`);

                              // ======================
                              // REVENUE MULTIPLE SECTION
                              // ======================
                              // tbody.append(`
                              //   <tr class="table-info fw-bold text-center">
                              //     <td colspan="4">Revenue Multiple (Revenue ÷ Total Cost)</td>
                              //   </tr>
                              // `);

                              // tbody.append(`
                              //   <tr>
                              //     <td class="text-start">Today</td>
                              //     <td></td>
                              //     <td>${todayMultiple.toFixed(1)}x</td>
                              //     <td>
                              //       <span class="badge ${todayMultipleStatus.class}">
                              //         ${todayMultipleStatus.label}
                              //       </span>
                              //     </td>
                              //   </tr>
                              // `);

                              // tbody.append(`
                              //   <tr>
                              //     <td class="text-start">Month To Date</td>
                              //     <td></td>
                              //     <td>${mtdMultiple.toFixed(1)}x</td>
                              //     <td>
                              //       <span class="badge ${mtdMultipleStatus.class}">
                              //         ${mtdMultipleStatus.label}
                              //       </span>
                              //     </td>
                              //   </tr>
                              // `);

                            }, 'json');

                          });

                          // sama seperti global
                          function getRatioBadgeClass(label) {
                            switch(label) {
                              case 'GOOD': return 'bg-label-success';
                              case 'AVERAGE': return 'bg-label-warning';
                              case 'OVER': return 'bg-label-danger';
                              case 'NOT OPTIMAL MAN POWER': return 'bg-label-danger';
                              case 'NO DATA': return 'bg-label-info';
                              default: return 'bg-label-secondary';
                            }
                          }
                        </script>
                        <?= $this->endSection() ?>