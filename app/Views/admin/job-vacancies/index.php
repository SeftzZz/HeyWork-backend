                        <?= $this->extend('layouts/main') ?>
                        <?= $this->section('content') ?>

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="card">
                                <div class="card-datatable table-responsive pt-0">
                                    <table class="dtJobVacancies table table-striped">
                                        <thead>
                                          <tr>
                                            <th></th>
                                            <th>No</th>
                                            <th>Position</th>
                                            <th>Category</th>
                                            <th>Date</th>
                                            <th>Location</th>
                                            <th>Fee</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                          </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
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
                                                    id="add_job_position" name="position" multiple class="form-select select2"
                                                    data-placeholder="Select Job Position" style="width:100%">
                                                    <option value=""></option>
                                                    <?php foreach ($skills as $skill): ?>
                                                        <option value="<?= $skill['name'] ?>">
                                                            <?= esc($skill['name']) ?>
                                                        </option>
                                                    <?php endforeach; ?>
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
                                              <input type="date" class="form-control" name="job_date_start" required>
                                            </div>

                                            <!-- END DATE -->
                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">Job End Date</label>
                                              <input type="date" class="form-control" name="job_date_end" required>
                                            </div>

                                          </div>

                                          <div class="row">

                                            <!-- FEE -->
                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">Fee</label>
                                              <input type="number" class="form-control" name="fee" required>
                                            </div>

                                            <!-- WORKER -->
                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">Workers</label>
                                              <input type="number" class="form-control" name="worker" required>
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

                                <!-- MODAL EDIT JOB -->
                                <div class="modal fade" id="modalEditJob" tabindex="-1" aria-hidden="true">
                                  <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content">

                                      <form id="formEditJob">
                                        <?= csrf_field() ?>
                                        <input type="hidden" name="id" id="edit_id">

                                        <div class="modal-header">
                                          <h5 class="modal-title">Edit Job Vacancy</h5>
                                          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>

                                        <div class="modal-body">

                                          <div class="row">

                                            <!-- POSITION -->
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Job Position</label>
                                                <select id="edit_job_position" name="position" class="form-select select2" style="width:100%">
                                                    <?php foreach ($skills as $skill): ?>
                                                        <option value="<?= esc($skill['name']) ?>">
                                                            <?= esc($skill['name']) ?>
                                                        </option>
                                                    <?php endforeach; ?>
                                                </select>
                                            </div>

                                            <!-- CATEGORY -->
                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">Category</label>
                                              <select class="form-select" name="category" id="edit_category" required>
                                                <option value="">-- Select Category --</option>
                                                <option value="daily_worker">Daily Worker</option>
                                                <option value="casual">Casual</option>
                                                <option value="corporate">Corporate</option>
                                              </select>
                                            </div>

                                          </div>

                                          <div class="row">
                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">Start Date</label>
                                              <input type="date" class="form-control" name="job_date_start" id="edit_job_date_start" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">End Date</label>
                                              <input type="date" class="form-control" name="job_date_end" id="edit_job_date_end" required>
                                            </div>
                                          </div>

                                          <div class="row">
                                            <!-- FEE -->
                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">Fee</label>
                                              <input type="number" class="form-control" name="fee" id="edit_fee">
                                            </div>

                                            <!-- WORKER -->
                                            <div class="col-md-6 mb-3">
                                              <label class="form-label">Workers</label>
                                              <input type="number" class="form-control" name="worker" id="edit_worker">
                                            </div>
                                          </div>

                                          <div class="mb-3">
                                            <label class="form-label">Description</label>
                                            <textarea class="form-control" name="description" id="edit_description" rows="3"></textarea>
                                          </div>

                                        </div>

                                        <div class="modal-footer">
                                          <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">
                                            Cancel
                                          </button>
                                          <button type="submit" class="btn btn-primary">
                                            Update Job
                                          </button>
                                        </div>

                                      </form>

                                    </div>
                                  </div>
                                </div>

                            </div>
                        </div>

                        <?= $this->endSection() ?>

                        <?= $this->section('scripts') ?>

                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-checkboxes-jquery/datatables.checkboxes.css') ?>" />
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css') ?>" />
                        <script src="<?= base_url('assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js') ?>"></script>
                        <!-- select2 -->
                        <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/select2/select2.css') ?>" />
                        <script src="<?= base_url('assets/vendor/libs/select2/select2.js') ?>"></script>

                        <script>
                            'use strict';
                            $(function () {
                                let dt_table = $('.dtJobVacancies'), dt_job;
                                if (dt_table.length) {
                                    dt_job = dt_table.DataTable({
                                        processing: true,
                                        serverSide: true,
                                        responsive: true,
                                        ajax: {
                                            url: "<?= base_url('admin/job-vacancies/datatable') ?>",
                                            type: "POST",
                                            data: d => {
                                                d['<?= csrf_token() ?>'] = '<?= csrf_hash() ?>';
                                            }
                                        },

                                        columns: [
                                            { defaultContent: '' }, // responsive control
                                            { data: 'no' },
                                            { data: 'position' },
                                            { data: 'category' },
                                            { data: 'date' },
                                            { data: 'location' },
                                            { data: 'fee' },
                                            { data: 'status' },
                                            { data: 'action' }
                                        ],

                                        columnDefs: [
                                            {
                                                targets: 0,
                                                className: 'control',
                                                orderable: false,
                                                searchable: false
                                            },
                                            {
                                                targets: 1,
                                                orderable: false,
                                                searchable: false
                                            },
                                            {
                                                targets: -1,
                                                orderable: false,
                                                searchable: false
                                            }
                                        ],

                                        dom:
                                            '<"card-header flex-column flex-md-row"' +
                                                '<"head-label text-center">' +
                                                '<"dt-action-buttons text-end pt-3 pt-md-0"B>' +
                                            '>' +
                                            '<"row"' +
                                                '<"col-sm-12 col-md-6"l>' +
                                                '<"col-sm-12 col-md-6 d-flex justify-content-center justify-content-md-end"f>' +
                                            '>' +
                                            't' +
                                            '<"row"' +
                                                '<"col-sm-12 col-md-6"i>' +
                                                '<"col-sm-12 col-md-6"p>' +
                                            '>',

                                        displayLength: 10,
                                        lengthMenu: [10, 25, 50, 100],

                                        buttons: [
                                            {
                                                extend: 'collection',
                                                className: 'btn btn-label-primary dropdown-toggle me-2',
                                                text: '<i class="ti ti-file-export me-sm-1"></i> <span class="d-none d-sm-inline-block">Export</span>',
                                                buttons: [
                                                    { extend: 'print', className: 'dropdown-item', exportOptions: { columns: [1,2,3,4,5,6,7,8] }},
                                                    { extend: 'csv',   className: 'dropdown-item', exportOptions: { columns: [1,2,3,4,5,6,7,8] }},
                                                    { extend: 'excel', className: 'dropdown-item', exportOptions: { columns: [1,2,3,4,5,6,7,8] }},
                                                    { extend: 'pdf',   className: 'dropdown-item', exportOptions: { columns: [1,2,3,4,5,6,7,8] }}
                                                ]
                                            },
                                            {
                                                text: '<i class="ti ti-plus me-sm-1"></i> <span class="d-sm-inline-block">Add New Job</span>',
                                                className: 'create-new btn btn-primary waves-effect waves-light',
                                                action: function () {
                                                    $('#modalAddJob').modal('show');
                                                }
                                            }
                                        ],

                                        responsive: {
                                            details: {
                                                display: $.fn.dataTable.Responsive.display.modal({
                                                    header: function (row) {
                                                        let data = row.data();
                                                        return 'Job Vacancy - ' + data.position;
                                                    }
                                                }),
                                                type: 'column',
                                                renderer: function (api, rowIdx, columns) {
                                                    let data = $.map(columns, function (col) {
                                                        return col.title !== ''
                                                            ? `<tr>
                                                                  <td>${col.title}:</td>
                                                                  <td>${col.data}</td>
                                                               </tr>`
                                                            : '';
                                                    }).join('');

                                                    return data
                                                        ? $('<table class="table"><tbody /></table>').append(data)
                                                        : false;
                                                }
                                            }
                                        }
                                    });

                                    $('div.head-label').html('<h5 class="card-title mb-0">Job Vacancies List</h5>');
                                }

                            });
                        </script>

                        <script>
                            'use strict';
                            $(function () {

                                // SUBMIT ADD JOB
                                $('#formAddJob').on('submit', function (e) {
                                    e.preventDefault();

                                    let form = $(this);
                                    let btn  = form.find('button[type="submit"]');

                                    btn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm"></span> Saving...');

                                    $.ajax({
                                      url: "<?= base_url('admin/job-vacancies/store') ?>",
                                      type: "POST",
                                      data: form.serialize(),
                                      dataType: "json",

                                      success: async function (res) {

                                        Swal.fire({
                                          icon: res.status ? 'success' : 'error',
                                          title: res.status ? 'Success' : 'Failed',
                                          text: res.message
                                        });

                                        if (!res.status) return;

                                        try {

                                          if (!res.data || !res.data.category) {
                                            throw new Error('Invalid job response (category missing)');
                                          }

                                          const jobPosition = $('#add_job_position').val();

                                          const startDate = new Date(res.data.job_date_start + 'T00:00:00');
                                          const endDate   = new Date(res.data.job_date_end + 'T00:00:00');

                                          // hitung selisih hari (inclusive)
                                          const diffTime = endDate - startDate;
                                          const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24)) + 1;

                                          // validasi
                                          if (diffDays <= 0) {
                                            throw new Error('Invalid job duration');
                                          }

                                          const feePerDay = Number(res.data.fee);
                                          const totalWorker = Number(res.data.worker);

                                          const totalPrice = feePerDay * totalWorker * diffDays;

                                          let payload = {
                                            company_id: 1,
                                            branch_name: window.hotelName,
                                            trx_date: new Date().toISOString().slice(0,10),
                                            trx_type: 'expense_payroll',
                                            reference_no: 'HW-' + Date.now(),
                                            amount: totalPrice,
                                            payment_account_id: 1,
                                            tax_code_id: 8
                                          }

                                          // ==== disable dulu sampai heycord production ====
                                          // const transactionRes = await fetch(window.urlApi + '/api/transactions', {
                                          //   method: 'POST',
                                          //   headers: {
                                          //     'Content-Type': 'application/json',
                                          //     Authorization: 'Bearer ' + window.jwtToken
                                          //   },
                                          //   body: JSON.stringify(payload)
                                          // });

                                          // const json = await transactionRes.json();

                                          // if (!json.status) {
                                          //   throw new Error(json.message || 'Gagal simpan PO');
                                          // }
                                          // ================================================

                                          // // =========================
                                          // // 1. CREATE CART
                                          // // =========================
                                          // const cartRes = await fetch(window.urlApi + '/api/cart/create', {
                                          //   method: 'POST',
                                          //   headers: {
                                          //     'Content-Type': 'application/json',
                                          //     Authorization: 'Bearer ' + window.jwtToken
                                          //   },
                                          //   body: JSON.stringify({
                                          //     hotel_id: window.hotelId,
                                          //     name: window.userName,
                                          //     phone: '-',
                                          //     email: window.userEmail,
                                          //     category: res.data.skill_category
                                          //   })
                                          // });

                                          // const cartJson = await cartRes.json();

                                          // if (!cartJson.status) {
                                          //   throw new Error(cartJson.message || 'Cart create failed');
                                          // }

                                          // const cartId = cartJson.data.cart_id;

                                          // // =========================
                                          // // 🔥 2. ADD ITEM
                                          // // =========================

                                          // const addRes = await fetch(window.urlApi + '/api/cart/add', {
                                          //   method: 'POST',
                                          //   headers: {
                                          //     'Content-Type': 'application/json',
                                          //     Authorization: 'Bearer ' + window.jwtToken
                                          //   },
                                          //   body: JSON.stringify({
                                          //     cart_id: cartId,
                                          //     category: res.data.category,
                                          //     quantity: totalWorker,
                                          //     price: totalPrice,
                                          //     date: new Date().toISOString().slice(0,10)
                                          //   })
                                          // });

                                          // const addJson = await addRes.json();

                                          // if (!addJson.status) {
                                          //   throw new Error(addJson.message || 'Add item failed');
                                          // }

                                          // // =========================
                                          // // 🔥 3. CHECKOUT
                                          // // =========================
                                          // const orderRes = await fetch(window.urlApi + '/api/orders/checkout', {
                                          //   method: 'POST',
                                          //   headers: {
                                          //     'Content-Type': 'application/json',
                                          //     Authorization: 'Bearer ' + window.jwtToken
                                          //   },
                                          //   body: JSON.stringify({
                                          //     cart_id: cartId,
                                          //     order_number: 'HW-' + Date.now(),
                                          //     payment_method: 'cash'
                                          //   })
                                          // });

                                          // const orderJson = await orderRes.json();

                                          // if (!orderJson.status) {
                                          //   throw new Error(orderJson.message || 'Checkout failed');
                                          // }

                                          // const orderId = orderJson.data.order_id;

                                          // if (!orderId) {
                                          //   throw new Error('order_id not returned from API');
                                          // }

                                          // // =========================
                                          // // 🔥 4. PAYMENT (NO trxType)
                                          // // =========================
                                          // const payRes = await fetch(window.urlApi + '/api/orders/pay', {
                                          //   method: 'POST',
                                          //   headers: {
                                          //     'Content-Type': 'application/json',
                                          //     Authorization: 'Bearer ' + window.jwtToken
                                          //   },
                                          //   body: JSON.stringify({
                                          //     order_id: orderId,
                                          //     deposit: 0,
                                          //     status: 'paid'
                                          //   })
                                          // });

                                          // const payJson = await payRes.json();

                                          // if (!payJson.status) {
                                          //   throw new Error(payJson.message || 'Payment failed');
                                          // }

                                          // =========================
                                          // SUCCESS
                                          // =========================
                                          $('#modalAddJob').modal('hide');
                                          form[0].reset();
                                          $('.dtJobVacancies').DataTable().ajax.reload(null, false);

                                        } catch (err) {

                                          console.error(err);

                                          Swal.fire({
                                            icon: 'error',
                                            title: 'Process Failed',
                                            text: err.message
                                          });

                                        }
                                      },

                                      error: function (xhr) {
                                        let msg = 'Server error';
                                        if (xhr.responseJSON && xhr.responseJSON.message) {
                                          msg = xhr.responseJSON.message;
                                        }
                                      },

                                      complete: function () {
                                        btn.prop('disabled', false).html('Save Job');
                                      }
                                    });
                                });

                                $('#formEditJob').on('submit', function (e) {
                                    e.preventDefault();
                                    let form = $(this);
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        icon: 'question',
                                        showCancelButton: true,
                                        confirmButtonText: 'Yes, update'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            $.post("<?= base_url('admin/job-vacancies/update') ?>",
                                                form.serialize(),
                                                function (res) {
                                                    if (res.status) {
                                                        Swal.fire({
                                                            icon: 'success',
                                                            title: 'Updated',
                                                            text: res.message,
                                                            timer: 1500,
                                                            showConfirmButton: false
                                                        });

                                                        $('#modalEditJob').modal('hide');
                                                        $('.dtJobVacancies').DataTable().ajax.reload(null, false);

                                                    } else {
                                                        Swal.fire('Failed', res.message, 'error');
                                                    }

                                                }, 'json'
                                            );
                                        }

                                    });

                                });

                                // =============================
                                // CLICK EDIT
                                // =============================
                                $(document).on('click', '.btn-edit-job', function () {
                                    const id = $(this).data('id');
                                    $.post("<?= base_url('admin/job-vacancies/get') ?>", {
                                        id: id,
                                        '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
                                    }, function (res) {
                                        if (res.status) {
                                            $('#edit_id').val(res.data.id);
                                            $('#edit_category').val(res.data.category);
                                            $('#edit_job_date_start').val(res.data.job_date_start);
                                            $('#edit_job_date_end').val(res.data.job_date_end);
                                            $('#edit_start_time').val(res.data.start_time);
                                            $('#edit_end_time').val(res.data.end_time);
                                            $('#edit_fee').val(res.data.fee);
                                            $('#edit_worker').val(res.data.worker);
                                            $('#edit_description').val(res.data.description);

                                            // SET POSITION
                                            $('#edit_job_position').val(res.data.position).trigger('change');

                                            $('#modalEditJob').modal('show');
                                        } else {
                                            Swal.fire('Failed', res.message, 'error');
                                        }

                                    }, 'json');
                                });

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
                                        dropdownParent: modal
                                    });
                                }

                                $('#modalAddJob').on('shown.bs.modal', function () {
                                    $('#add_job_position').select2({
                                        placeholder: 'Select Job Position',
                                        allowClear: true,
                                        dropdownParent: $('#modalAddJob')
                                    });
                                });

                                $('#modalAddJob').on('hidden.bs.modal', function () {
                                    $('#add_job_position').val(null).trigger('change');
                                    const form = $('#formAddJob');
                                    // Reset form native
                                    form[0].reset();

                                    // Reset Select2
                                    $('#add_job_position').val(null).trigger('change');

                                    // Kosongkan end time manual (karena readonly)
                                    $('#add_end_time').val('');
                                });

                                $('#modalEditJob').on('shown.bs.modal', function () {
                                  $('#edit_job_position').select2({
                                      placeholder: 'Select Job Position',
                                      allowClear: true,
                                      dropdownParent: $('#modalEditJob')
                                  });
                                });

                                $('#modalEditJob').on('hidden.bs.modal', function () {
                                    $('#edit_job_position').val(null).trigger('change');
                                });

                                function initEditJobPositionSelect2() {
                                    if ($('#edit_job_position').hasClass('select2-hidden-accessible')) {
                                        $('#edit_job_position').select2('destroy');
                                    }

                                    $('#edit_job_position').select2({
                                        placeholder: 'Select Job Position',
                                        allowClear: true,
                                        closeOnSelect: false,
                                        dropdownParent: $('#modalEditJob'),
                                        ajax: {
                                            url: "<?= base_url('admin/job-vacancies/skills') ?>",
                                            dataType: 'json',
                                            delay: 250,
                                            data: function (params) {
                                                return { q: params.term };
                                            },
                                            processResults: function (data) {
                                                return { results: data.results };
                                            }
                                        }
                                    });
                                }

                            });
                        </script>

                        <script>
                            $(function () {
                                function autoSetEndTime(startSelector, endSelector) {
                                    $(document).on('change', startSelector, function () {
                                        let startTime = $(this).val();
                                        if (!startTime) return;
                                        let [hours, minutes] = startTime.split(':').map(Number);
                                        let date = new Date();
                                        date.setHours(hours);
                                        date.setMinutes(minutes);
                                        date.setSeconds(0);

                                        // tambah 9 jam
                                        date.setHours(date.getHours() + 9);

                                        let endHours   = String(date.getHours()).padStart(2, '0');
                                        let endMinutes = String(date.getMinutes()).padStart(2, '0');

                                        let endTime = endHours + ':' + endMinutes;

                                        $(endSelector).val(endTime);
                                    });
                                }
                                // Apply ke Add Form
                                autoSetEndTime('input[name="start_time"]', '#add_end_time');

                                // Apply ke Edit Form
                                autoSetEndTime('#edit_start_time', '#edit_end_time');
                            });
                        </script>

                        <?= $this->endSection() ?>
