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
                                <!-- Generated Leads -->
                                <div class="col-xl-3 mb-4 col-md-6">
                                  <div class="card">
                                    <div class="card-body">
                                      <div class="d-flex justify-content-between">
                                        <div class="d-flex flex-column">
                                          <div class="card-title mb-auto">
                                            <h5 class="mb-1 text-nowrap">Partners</h5>
                                          </div>
                                          <div class="chart-statistics">
                                            <h3 class="card-title mb-1" id="partnerTotal">0</h3>
                                          </div>
                                        </div>
                                        <div id="generatedLeadsChart"></div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                <!--/ Generated Leads -->

                                <!-- Sessions Last month -->
                                <div class="col-xl-3 col-md-4 col-6 mb-4">
                                  <div class="card">
                                    <div class="card-body">
                                      <div class="badge p-2 bg-label-primary mb-2 rounded">
                                        <i class="ti ti-building ti-md"></i>
                                      </div>
                                      <h5 class="card-title mb-1 pt-2">Corporate/Hotels</h5>
                                      <h4 class="card-title mt-1" id="hotelTotal">0</h4>
                                    </div>
                                  </div>
                                </div>

                                <!-- Total Profit -->
                                <div class="col-xl-3 col-md-4 col-6 mb-4">
                                  <div class="card">
                                    <div class="card-body">
                                      <div class="badge p-2 bg-label-info mb-2 rounded">
                                        <i class="ti ti-briefcase ti-md"></i>
                                      </div>
                                      <h5 class="card-title mb-1 pt-2">Job Postings</h5>
                                      <h4 class="card-title mt-1" id="jobPostingTotal">0</h4>
                                    </div>
                                  </div>
                                </div>

                                <!-- Total Sales -->
                                <div class="col-xl-3 col-md-4 col-6 mb-4">
                                  <div class="card">
                                    <div class="card-body">
                                      <div class="badge p-2 bg-label-success mb-2 rounded">
                                        <i class="ti ti-list-check ti-md"></i>
                                      </div>
                                      <h5 class="card-title mb-1 pt-2">Completed Jobs</h5>
                                      <h4 class="card-title mt-1" id="completedJobsTotal">0</h4>
                                    </div>
                                  </div>
                                </div>
                              </div>

                              <div class="card app-calendar-wrapper">
                                <div class="row g-0">
                                  <!-- Calendar Sidebar -->
                                  <div class="col app-calendar-sidebar" id="app-calendar-sidebar">
                                    <div class="p-3">
                                      <!-- inline calendar (flatpicker) -->
                                      <div class="inline-calendar"></div>

                                      <hr class="container-m-nx mb-4 mt-3" />

                                      <!-- Filter -->
                                      <div class="mb-3 ms-3">
                                        <small class="text-small text-muted text-uppercase align-middle">Filter</small>
                                      </div>

                                      <div class="app-calendar-events-filter ms-3" id="jobFilterContainer">
                                          <!-- GENERATED BY JS -->
                                      </div>

                                    </div>
                                  </div>
                                  <!-- /Calendar Sidebar -->

                                  <!-- Calendar & Modal -->
                                  <div class="col app-calendar-content">
                                    <div class="card shadow-none border-0">
                                      <div class="card-body pb-0">
                                        <!-- FullCalendar -->
                                        <div id="calendar"></div>
                                      </div>
                                    </div>
                                    <div class="app-overlay"></div>
                                    <!-- FullCalendar Offcanvas -->
                                    <div
                                      class="offcanvas offcanvas-end event-sidebar"
                                      tabindex="-1"
                                      id="addEventSidebar"
                                      aria-labelledby="addEventSidebarLabel">
                                      <div class="offcanvas-header my-1">
                                        <h5 class="offcanvas-title" id="addEventSidebarLabel">
                                          Job Attendance Detail
                                        </h5>

                                        <button
                                          type="button"
                                          class="btn-close text-reset"
                                          data-bs-dismiss="offcanvas"
                                          aria-label="Close"></button>
                                      </div>
                                      <div class="offcanvas-body pt-0">

                                          <!-- JOB INFO -->
                                          <div class="mb-4">
                                            <h6 class="text-uppercase text-muted mb-2">Job Information</h6>

                                            <div class="mb-2">
                                              <small class="text-muted">Position</small>
                                              <div class="fw-semibold" id="job_position">-</div>
                                            </div>

                                            <div class="mb-2">
                                              <small class="text-muted">Category</small>
                                              <div id="job_category">-</div>
                                            </div>

                                            <div class="mb-2">
                                              <small class="text-muted">Date</small>
                                              <div id="job_date">-</div>
                                            </div>

                                            <div class="mb-2">
                                              <small class="text-muted">Time</small>
                                              <div id="job_time">-</div>
                                            </div>

                                            <div class="mb-2">
                                              <small class="text-muted">Fee</small>
                                              <div id="job_fee">-</div>
                                            </div>

                                            <div class="mb-2">
                                              <small class="text-muted">Location</small>
                                              <div id="job_location">-</div>
                                            </div>

                                            <div class="mb-2">
                                              <small class="text-muted">Status</small>
                                              <span class="badge bg-success" id="job_status">-</span>
                                            </div>
                                          </div>

                                          <hr>

                                          <!-- ATTENDANCE -->
                                            <div>
                                              <h6 class="text-uppercase text-muted mb-3">Attendance Records</h6>

                                              <div id="attendanceContainer">
                                                <div class="text-muted">No attendance data</div>
                                              </div>
                                            </div>


                                      </div>
                                    </div>
                                    <div class="modal fade" id="modalAddJob" tabindex="-1" aria-hidden="true">
                                      <div class="modal-dialog modal-lg modal-dialog-centered">
                                        <div class="modal-content">

                                          <form id="formAddJob">
                                            <?= csrf_field() ?>

                                            <div class="modal-header">
                                              <h5 class="modal-title">Add New Job</h5>
                                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>

                                            <div class="modal-body">
                                              <div class="row">

                                                <!-- JOB POSITION -->
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Job Position</label>
                                                    <select
                                                        name="position[]"
                                                        id="add_job_position"
                                                        class="form-select select2"
                                                        data-placeholder="Select Job Position"
                                                        style="width:100%"
                                                        multiple
                                                        required>
                                                    </select>
                                                </div>

                                                <!-- CATEGORY -->
                                                <div class="col-md-6 mb-3">
                                                  <label class="form-label">Category</label>
                                                  <select class="form-select" name="category" required>
                                                    <option value="">-- Select Category --</option>
                                                    <option value="daily_worker">Daily Worker</option>
                                                    <option value="casual">Casual</option>
                                                    <option value="corporate">Corporate</option>
                                                  </select>
                                                </div>

                                              </div>

                                              <div class="row">

                                                <!-- START DATE -->
                                                <div class="col-md-6 mb-3">
                                                  <label class="form-label">Job Start Date</label>
                                                  <input type="date" class="form-control" name="job_date_start" id="job_date_start" required>
                                                </div>

                                                <!-- END DATE -->
                                                <div class="col-md-6 mb-3">
                                                  <label class="form-label">Job End Date</label>
                                                  <input type="date" class="form-control" name="job_date_end" id="job_date_end" required>
                                                </div>

                                              </div>

                                              <div class="row">

                                                <!-- FEE -->
                                                <div class="col-md-12 mb-3">
                                                  <label class="form-label">Fee</label>
                                                  <input type="number" class="form-control" name="fee">
                                                </div>

                                              </div>

                                              <!-- DESCRIPTION -->
                                              <div class="mb-3">
                                                <label class="form-label">Job Description</label>
                                                <textarea class="form-control" name="description" rows="3"></textarea>
                                              </div>

                                              <!-- STATUS (hidden, default open) -->
                                              <input type="hidden" name="status" value="open">

                                            </div>

                                            <div class="modal-footer">
                                              <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">
                                                Cancel
                                              </button>
                                              <button type="submit" class="btn btn-primary">
                                                Save & Publish
                                              </button>
                                            </div>

                                          </form>

                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                  <!-- /Calendar & Modal -->
                                </div>
                              </div>
                            </div>
                        <?= $this->endSection() ?>
                        
                        <?= $this->section('scripts') ?>

                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/node-waves/node-waves.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/typeahead-js/typeahead.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/fullcalendar/fullcalendar.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/flatpickr/flatpickr.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/select2/select2.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/quill/editor.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/@form-validation/form-validation.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/css/pages/app-calendar.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/toastr/toastr.css') ?>">

                        <!-- Vendors JS (WAJIB URUT) -->
                        <script src="<?= base_url('assets/vendor/libs/fullcalendar/fullcalendar.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/moment/moment.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/flatpickr/flatpickr.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/select2/select2.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/@form-validation/popular.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/@form-validation/bootstrap5.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/@form-validation/auto-focus.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/toastr/toastr.js') ?>"></script>
                        <script src="<?= base_url('assets/vendor/libs/apex-charts/apexcharts.js') ?>"></script>

                        <!-- Main JS (HANYA SEKALI, PASTIKAN TIDAK DOUBLE DI LAYOUT) -->
                        <!-- <script src="<?= base_url('assets/js/main.js') ?>"></script> -->

                        <!-- Dummy Events (template) -->
                        <script src="<?= base_url('assets/js/app-calendar-events.js') ?>"></script>

                        <script>
                          window.TEMPLATE_COLORS = [
                            'primary',
                            'success',
                            'danger',
                            'warning',
                            'info',
                            'dark'
                          ];
                        </script>

                        <script>
                          window.events = [];
                          window.calendarsColor = {}; // ❗ JANGAN RESET LAGI
                        </script>

                        <script>
                          function loadJobCalendar() {

                            fetch('<?= base_url('admin/dashboard/calendar') ?>')
                              .then(res => res.json())
                              .then(data => {

                                // ============================
                                // 1. Update events (replace isi)
                                // ============================
                                window.events.splice(0, window.events.length, ...data);

                                // ============================
                                // 2. Ambil posisi unik
                                // ============================
                                const positions = [...new Set(
                                  data.map(ev => ev.extendedProps.calendar)
                                )];

                                // ============================
                                // 3. ASSIGN WARNA (HANYA JIKA BELUM ADA)
                                // ============================
                                let colorIndex = Object.keys(window.calendarsColor).length;

                                positions.forEach(position => {
                                  if (!window.calendarsColor[position]) {
                                    window.calendarsColor[position] =
                                      window.TEMPLATE_COLORS[colorIndex % window.TEMPLATE_COLORS.length];
                                    colorIndex++;
                                  }
                                });

                                // ============================
                                // 4. Generate filter (UI)
                                // ============================
                                const container = document.getElementById('jobFilterContainer');
                                container.innerHTML = '';

                                positions.forEach(position => {
                                  const value = position.toLowerCase();
                                  const id = 'filter-' + value.replace(/\s+/g, '-');
                                  const color = window.calendarsColor[position];

                                  container.insertAdjacentHTML('beforeend', `
                                    <div class="form-check mb-2">
                                      <input
                                        class="form-check-input input-filter"
                                        type="checkbox"
                                        id="${id}"
                                        data-value="${value}"
                                        checked
                                      />
                                      <label class="form-check-label d-flex align-items-center gap-2" for="${id}">
                                        <span class="badge badge-dot bg-${color}"></span>
                                        ${position}
                                      </label>
                                    </div>
                                  `);
                                });

                                // ============================
                                // 5. Filter listener
                                // ============================
                                document.querySelectorAll('.input-filter').forEach(el => {
                                  el.addEventListener('change', () => {
                                    if (window.calendar) {
                                      window.calendar.refetchEvents();
                                    }
                                  });
                                });

                                // ============================
                                // 6. Refresh calendar
                                // ============================
                                if (window.calendar) {
                                  window.calendar.refetchEvents();
                                }
                              })
                              .catch(err => {
                                console.error('Failed load job calendar', err);
                              });
                          }

                          // 🔥 LOAD PERTAMA KALI
                          document.addEventListener('DOMContentLoaded', loadJobCalendar);
                        </script>

                        <!-- App Calendar Logic (template) -->
                        <script src="<?= base_url('assets/js/app-calendar.js') ?>"></script>

                        <script>
                          /**
                           * ============================
                           * READONLY EVENT CLICK HANDLER
                           * ============================
                           */
                          document.addEventListener('DOMContentLoaded', function () {
                            // tunggu sampai calendar benar-benar ada
                            const waitCalendar = setInterval(() => {
                              if (!window.calendar) return;

                              clearInterval(waitCalendar);

                              // override eventClick TANPA MERUSAK FILTER
                              window.calendar.setOption('eventClick', function (info) {

                                const event = info.event;
                                const jobId = event.extendedProps.job_id;

                                // ======================
                                // JOB INFO (READONLY)
                                // ======================
                                document.getElementById('job_position').innerText =
                                  event.title ?? '-';

                                document.getElementById('job_category').innerText =
                                  event.extendedProps.category ?? '-';

                                document.getElementById('job_date').innerText =
                                  event.start.toLocaleDateString('id-ID') +
                                  ' - ' +
                                  event.end.toLocaleDateString('id-ID');

                                document.getElementById('job_time').innerText =
                                  event.start.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' }) +
                                  ' - ' +
                                  event.end.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });

                                document.getElementById('job_fee').innerText =
                                  'Rp ' + Number(event.extendedProps.fee).toLocaleString('id-ID');

                                document.getElementById('job_location').innerText =
                                  event.extendedProps.location ?? '-';

                                const statusBadge = document.getElementById('job_status');
                                statusBadge.innerText = event.extendedProps.status ?? '-';
                                statusBadge.className =
                                  'badge ' + (event.extendedProps.status === 'open'
                                    ? 'bg-success'
                                    : 'bg-secondary');

                                // ======================
                                // LOAD ATTENDANCE (API)
                                // ======================
                                const container = document.getElementById('attendanceContainer');
                                container.innerHTML =
                                  '<div class="text-muted">Loading attendance...</div>';

                                fetch(`<?= base_url('admin/dashboard/calendar-attendance') ?>/${jobId}`)
                                  .then(res => res.json())
                                  .then(rows => {

                                      if (!rows || !rows.length) {
                                        container.innerHTML =
                                          '<div class="text-muted">No attendance record</div>';
                                        return;
                                      }

                                      let html = '<ul class="list-group list-group-flush">';

                                      rows.forEach(row => {

                                        const mapUrl = row.latitude && row.longitude
                                          ? `https://www.google.com/maps?q=${row.latitude},${row.longitude}`
                                          : null;

                                        const photoUrl = row.photo_path
                                          ? `<?= base_url() ?>/${row.photo_path}`
                                          : null;

                                        html += `
                                          <li class="list-group-item">
                                            <div class="d-flex justify-content-between align-items-center">
                                              <div>
                                                <span class="badge bg-primary text-uppercase">
                                                  ${row.type}
                                                </span>
                                                <div class="small text-muted mt-1">
                                                  ${new Date(row.created_at).toLocaleString('id-ID')}
                                                </div>
                                              </div>
                                            </div>

                                            ${mapUrl ? `
                                              <div class="mt-2">
                                                <a href="${mapUrl}" target="_blank" class="small text-primary">
                                                  📍 View Location
                                                </a>
                                              </div>
                                            ` : ''}

                                            ${photoUrl ? `
                                              <div class="mt-2">
                                                <img src="${photoUrl}" class="img-fluid rounded" style="max-height:120px">
                                              </div>
                                            ` : ''}

                                            ${row.device_info ? `
                                              <div class="mt-2 small text-muted">
                                                🖥 ${row.device_info}
                                              </div>
                                            ` : ''}
                                          </li>
                                        `;
                                      });

                                      html += '</ul>';
                                      container.innerHTML = html;
                                    })

                                  .catch(() => {
                                    container.innerHTML =
                                      '<div class="text-danger">Failed load attendance</div>';
                                  });

                                // ======================
                                // SHOW OFFCANVAS
                                // ======================
                                const offcanvasEl =
                                  document.getElementById('addEventSidebar');

                                const offcanvas =
                                  bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);

                                offcanvas.show();
                              });
                            }, 100);
                          });
                        </script>

                        <script>
                          let cardColor, labelColor, headingColor, borderColor, legendColor;

                          if (isDarkStyle) {
                            cardColor = config.colors_dark.cardColor;
                            labelColor = config.colors_dark.textMuted;
                            legendColor = config.colors_dark.bodyColor;
                            headingColor = config.colors_dark.headingColor;
                            borderColor = config.colors_dark.borderColor;
                          } else {
                            cardColor = config.colors.cardColor;
                            labelColor = config.colors.textMuted;
                            legendColor = config.colors.bodyColor;
                            headingColor = config.colors.headingColor;
                            borderColor = config.colors.borderColor;
                          }

                          // Donut Chart Colors
                          const chartColors = {
                            donut: {
                              series1: config.colors.success,
                              series2: '#28c76fb3',
                              series3: '#28c76f80',
                              series4: config.colors_label.success
                            }
                          };

                          // ===============================================
                          // CHART CONFIG
                          // ===============================================

                          const generatedLeadsChartEl = document.querySelector('#generatedLeadsChart');

                          const generatedLeadsChartConfig = {
                            chart: {
                              height: 147,
                              width: 130,
                              parentHeightOffset: 0,
                              type: 'donut'
                            },
                            labels: ['Female', 'Male'],
                            series: [0, 0], // default kosong
                            colors: [
                              config.colors.success,
                              '#28c76fb3'
                            ],
                            stroke: {
                              width: 0
                            },
                            dataLabels: {
                              enabled: false
                            },
                            legend: {
                              show: false
                            },
                            plotOptions: {
                              pie: {
                                donut: {
                                  size: '70%',
                                  labels: {
                                    show: true,
                                    value: {
                                      fontSize: '1.375rem',
                                      fontFamily: 'Public Sans',
                                      color: headingColor,
                                      fontWeight: 500,
                                      offsetY: -15
                                    },
                                    name: {
                                      offsetY: 20
                                    },
                                    total: {
                                      show: true,
                                      showAlways: true,
                                      label: 'Total',
                                      formatter: function (w) {
                                        return w.globals.seriesTotals.reduce((a, b) => a + b, 0);
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          };

                          // ===============================================
                          // INIT CHART
                          // ===============================================

                          let generatedLeadsChart = null;

                          if (generatedLeadsChartEl) {
                            generatedLeadsChart = new ApexCharts(
                              generatedLeadsChartEl,
                              generatedLeadsChartConfig
                            );
                            generatedLeadsChart.render();
                          }

                          // ===============================================
                          // LOAD PARTNERS (AJAX)
                          // ===============================================

                          function loadPartners() {
                            $.ajax({
                              url: `<?= base_url('admin/users/get-partner') ?>`,
                              type: 'POST',
                              dataType: 'json',
                              success: function (res) {

                                if (!res.status) return;

                                let femaleCount = 0;
                                let maleCount = 0;

                                res.data.forEach(function (item) {

                                  const gender = item.gender
                                    ? item.gender.toLowerCase().trim()
                                    : '';

                                  if (gender === 'female') {
                                    femaleCount++;
                                  } else if (gender === 'male') {
                                    maleCount++;
                                  }

                                });

                                const total = femaleCount + maleCount;

                                // Update angka besar
                                $('#partnerTotal').text(total);

                                // Update chart
                                if (generatedLeadsChart) {
                                  generatedLeadsChart.updateSeries([femaleCount, maleCount]);
                                }

                                // Optional: hide chart kalau kosong
                                if (total === 0) {
                                  $('#generatedLeadsChart').hide();
                                } else {
                                  $('#generatedLeadsChart').show();
                                }

                              }
                            });
                          }

                          function loadTotalHotels() {
                              $.ajax({
                                  url: `<?= base_url('admin/hotels/get-total') ?>`,
                                  type: 'POST',
                                  dataType: 'json',
                                  success: function (res) {

                                      if (!res.status) return;

                                      let total = res.total;

                                      // Format angka jika > 1000
                                      if (total >= 1000) {
                                          total = (total / 1000).toFixed(2) + 'k';
                                      }

                                      $('#hotelTotal').text(total);
                                  }
                              });
                          }

                          function loadTotalJobPostings() {
                              $.ajax({
                                  url: `<?= base_url('admin/job-vacancies/get-total-postings') ?>`,
                                  type: 'POST',
                                  dataType: 'json',
                                  success: function (res) {

                                      if (!res.status) return;

                                      let total = res.total;

                                      // Format ke K kalau ribuan
                                      if (total >= 1000) {
                                          total = (total / 1000).toFixed(2) + 'k';
                                      }

                                      $('#jobPostingTotal').text(total);
                                  }
                              });
                          }

                          function loadTotalCompletedJobs() {
                              $.ajax({
                                  url: `<?= base_url('admin/application/get-total-completed') ?>`,
                                  type: 'POST',
                                  dataType: 'json',
                                  success: function (res) {

                                      if (!res.status) return;

                                      let total = res.total;

                                      if (total >= 1000) {
                                          total = (total / 1000).toFixed(2) + 'k';
                                      }

                                      $('#completedJobsTotal').text(total);
                                  }
                              });
                          }

                          // ===============================================
                          // CALL FUNCTION
                          // ===============================================

                          $(document).ready(function () {
                            loadPartners();
                            loadTotalHotels();
                            loadTotalJobPostings();
                            loadTotalCompletedJobs();
                          });
                        </script>

                        <script>
                          document.addEventListener('DOMContentLoaded', function () {

                            const waitCalendar = setInterval(() => {

                              if (!window.calendar) return;
                              clearInterval(waitCalendar);

                              window.calendar.setOption('dateClick', function (info) {

                                const clickedDate = moment(info.date).startOf('day');
                                const today = moment().startOf('day');

                                // ❌ blok tanggal kemarin & sebelumnya
                                if (clickedDate.isBefore(today)) {
                                  return;
                                }

                                // ✅ format dd-mm-yyyy (SESUAI INPUT)
                                const date = clickedDate.format('DD-MM-YYYY');
                                const modal = $('#modalAddJob');

                                if (!modal.length) return;

                                modal.find('input[name="job_date_start"]');
                                modal.find('input[name="job_date_end"]');

                                modal.modal('show');
                              });

                            }, 100);

                          });
                        </script>

                        <script>
                            $(document).ready(function () {

                                function initJobPositionSelect2(selector, modal) {

                                    if ($(selector).hasClass('select2-hidden-accessible')) {
                                        $(selector).select2('destroy');
                                    }

                                    $(selector).select2({
                                        placeholder: 'Select Job Position',
                                        allowClear: true,
                                        closeOnSelect: false, // 🔥 penting untuk multi select
                                        dropdownParent: modal,
                                        ajax: {
                                            url: "<?= base_url('admin/job-vacancies/skills') ?>",
                                            dataType: 'json',
                                            delay: 250,
                                            data: function (params) {
                                                return { q: params.term };
                                            },
                                            processResults: function (data) {
                                                return { results: data.results };
                                            },
                                            cache: true
                                        }
                                    });
                                }

                                $('#modalAddJob').on('shown.bs.modal', function () {
                                    initJobPositionSelect2('#add_job_position', $(this));
                                });

                                $('#modalAddJob').on('hidden.bs.modal', function () {
                                    $('#add_job_position').val(null).trigger('change');
                                });

                            });
                        </script>

                        <script>
                          document.addEventListener('DOMContentLoaded', function () {

                            flatpickr('#job_date_start', {
                              dateFormat: 'Y-m-d',
                              allowInput: true,
                              minDate: 'today'
                            });

                            flatpickr('#job_date_end', {
                              dateFormat: 'Y-m-d',
                              allowInput: true,
                              minDate: 'today'
                            });

                          });
                        </script>

                        <script>
                          'use strict';

                          $(function () {

                            $('#formAddJob').on('submit', function (e) {
                              e.preventDefault();

                              let form = $(this);
                              let btn  = form.find('button[type="submit"]');

                              btn.prop('disabled', true)
                                 .html('<span class="spinner-border spinner-border-sm"></span> Saving...');

                              $.ajax({
                                url: "<?= base_url('admin/job-vacancies/store') ?>",
                                type: "POST",
                                data: form.serialize(),
                                dataType: "json",

                                success: function (res) {

                                  if (res.status === true) {

                                    $('#modalAddJob').modal('hide');
                                    form[0].reset();

                                    // 🔥 RELOAD CALENDAR (WARNA TETAP)
                                    loadJobCalendar();

                                    toastr.success(res.message ?? 'Job successfully added');

                                  } else {
                                    toastr.error(res.message ?? 'Failed to save job');
                                  }
                                },

                                error: function (xhr) {
                                  let msg = 'Server error';
                                  if (xhr.responseJSON && xhr.responseJSON.message) {
                                    msg = xhr.responseJSON.message;
                                  }
                                  toastr.error(msg);
                                },

                                complete: function () {
                                  btn.prop('disabled', false).html('Save Job');
                                }
                              });
                            });

                          });
                        </script>

                        <script>
                          (function () {
                            let ws;
                            let reconnectInterval = 3000;
                            let isManuallyClosed = false;

                            function connectWS() {
                              const protocol = window.location.protocol === 'https:' ? 'wss' : 'ws';

                              // GANTI domain jika beda server
                              const wsUrl = `${protocol}://${window.location.hostname}:3004`;
                                                            
                              // gunakan line ini untuk settingan server
                              //const wsUrl = ${protocol}://${window.location.hostname}/ws/;

                              // gunakan line ini untuk settingan server
                              // const wsUrl = `${protocol}://${window.location.hostname}/ws/`;

                              ws = new WebSocket(wsUrl);

                              console.log('Connecting WS:', wsUrl);

                              ws.onopen = function () {
                                console.log('✅ WS Connected');
                              };

                              ws.onmessage = function (event) {

                                try {
                                  const data = JSON.parse(event.data);

                                  console.log('📩 WS Message:', data);

                                  if (!data.type) return;

                                  /**
                                   * =============================
                                   * HANDLE EVENT TYPES
                                   * =============================
                                   */

                                  // 🔄 Refresh Calendar
                                  if (data.type === 'job_update' || data.type === 'job_created') {
                                    if (typeof loadJobCalendar === 'function') {
                                      loadJobCalendar();
                                    }
                                  }

                                  // 🔄 Attendance Update
                                  if (data.type === 'attendance_update') {

                                    // Jika offcanvas sedang terbuka dan job sama
                                    const currentJobId = document.getElementById('job_position')
                                      ? document.getElementById('job_position').dataset.jobId
                                      : null;

                                    if (data.job_id && window.calendar) {
                                      window.calendar.refetchEvents();
                                    }
                                  }
                                  
                                } catch (e) {
                                  console.error('WS parse error', e);
                                }
                              };

                              ws.onclose = function () {
                                console.log('❌ WS Disconnected');

                                if (!isManuallyClosed) {
                                  setTimeout(connectWS, reconnectInterval);
                                }
                              };

                              ws.onerror = function (err) {
                                console.error('WS Error:', err);
                                ws.close();
                              };
                            }

                            // connect pertama kali
                            connectWS();

                            // optional: cleanup saat page unload
                            window.addEventListener('beforeunload', function () {
                              isManuallyClosed = true;
                              if (ws) ws.close();
                            });

                          })();
                        </script>

                        <?= $this->endSection() ?>
