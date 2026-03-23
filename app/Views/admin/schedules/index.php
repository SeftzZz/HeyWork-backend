<?= $this->extend('layouts/main') ?>
<?= $this->section('content') ?>

<div class="container-xxl flex-grow-1 container-p-y">
    <div class="card">
        <div class="card-datatable table-responsive pt-0">
            <table class="dtSchedule table table-striped">
                <thead>
                    <tr>
                        <th></th>
                        <th>No.</th>
                        <th>Department</th>
                        <th>Month</th>
                        <th>Year</th>
                        <th>Status</th>
                        <th>Requested By</th>
                        <th>Created At</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <!-- ========================= -->
    <!-- CREATE SCHEDULE MODAL -->
    <!-- ========================= -->
    <div class="modal fade" id="modalAddSchedule" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">
                <form id="formAddSchedule">
                    <div class="modal-header">
                        <h5 class="modal-title">Create Schedule Plan</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <?php 
                            $userRole = session()->get('user_role');

                            $allDepartments = [
                                'Front Office',
                                'Housekeeping',
                                'Food & Beverage Service',
                                'Kitchen / Culinary',
                                'Human Resources',
                                'Sales & Marketing',
                                'Finance',
                                'Engineering',
                                'Management'
                            ];

                            $roleDepartmentMap = [
                                'hotel_fo'             => ['Front Office'],
                                'hotel_hk'             => ['Housekeeping'],
                                'hotel_fnb_service'    => ['Food & Beverage Service'],
                                'hotel_fnb_production' => ['Kitchen / Culinary'],
                                'hotel_fna'            => ['Finance'],
                                'hotel_eng'            => ['Engineering'],
                                'hotel_sales'          => ['Sales & Marketing'],
                            ];

                            if (in_array($userRole, ['admin','hotel_hr','hotel_gm'])) {
                                $departments = $allDepartments;
                            } else {
                                $departments = $roleDepartmentMap[$userRole] ?? [];
                            }
                        ?>

                        <?php if(!empty($departments)): ?>
                            <div class="mb-3">
                                <label class="form-label">Department</label>
                                <select name="department" class="form-select" required>
                                    <option value="">Select Department</option>
                                    <?php foreach($departments as $dept): ?>
                                        <option value="<?= esc($dept) ?>">
                                            <?= esc($dept) ?>
                                        </option>
                                    <?php endforeach; ?>

                                </select>
                            </div>
                        <?php endif; ?>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Month</label>
                                <select name="month" class="form-select" required>
                                    <?php for($m=1; $m<=12; $m++): ?>
                                        <option value="<?= $m ?>" <?= $m == date('n') ? 'selected' : '' ?>>
                                            <?= date('F', mktime(0,0,0,$m,1)) ?>
                                        </option>
                                    <?php endfor; ?>
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Year</label>
                                <select name="year" class="form-select" required>
                                    <?php for($y=date('Y')-1; $y<=date('Y')+1; $y++): ?>
                                        <option value="<?= $y ?>" <?= $y == date('Y') ? 'selected' : '' ?>>
                                            <?= $y ?>
                                        </option>
                                    <?php endfor; ?>
                                </select>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>

                </form>

            </div>
        </div>
    </div>

    <!-- ========================= -->
    <!-- VIEW SCHEDULE MODAL -->
    <!-- ========================= -->
    <div class="modal fade" id="modalViewSchedule" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Schedule Detail</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <!-- HEADER INFO -->
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <strong>Department:</strong>
                            <div id="view_department"></div>
                        </div>
                        <div class="col-md-3">
                            <strong>Month:</strong>
                            <div id="view_month"></div>
                        </div>
                        <div class="col-md-2">
                            <strong>Year:</strong>
                            <div id="view_year"></div>
                        </div>
                        <div class="col-md-2">
                            <strong>Status:</strong>
                            <div id="view_status"></div>
                        </div>
                    </div>

                    <hr>

                    <!-- DETAIL TABLE -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-sm">
                            <thead class="table-light">
                                <tr>
                                    <th>Date</th>
                                    <th>Worker</th>
                                    <th>Shift</th>
                                </tr>
                            </thead>
                            <tbody id="view_schedule_body">
                                <tr>
                                    <td colspan="3" class="text-center">Loading...</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <!-- modal add Shift  -->
    <div class="modal fade" id="modalAssignShift">
      <div class="modal-dialog">
        <div class="modal-content">
          <form id="formAssignShift">
            <div class="modal-header">
              <h5 class="modal-title">Assign Shift</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

              <input type="hidden" name="schedule_plan_id" id="assign_plan_id">
              <input type="hidden" name="shift_date" id="assign_shift_date">

              <div class="mb-3">
                <label>Worker</label>
                <select name="user_id" class="form-control select2" required>
                  <option value="">Select Worker</option>
                  <?php foreach($workers as $w): ?>
                    <option value="<?= $w['id'] ?>">
                      <?= esc($w['name']) ?>
                    </option>
                  <?php endforeach; ?>
                </select>
              </div>

              <div class="row">
                <div class="col">
                  <label>Start</label>
                  <input type="time" name="start_time" class="form-control" required>
                </div>
                <div class="col">
                  <label>End</label>
                  <input type="time" name="end_time" class="form-control" required>
                </div>
              </div>

              <div class="mt-3">
                <label>Shift Type</label>
                <select name="shift_type" class="form-control">
                  <option value="regular">Regular</option>
                  <option value="overtime">Overtime</option>
                  <option value="leave">Leave</option>
                  <option value="off">Off</option>
                </select>
              </div>

            </div>

            <div class="modal-footer">
              <button class="btn btn-primary">Save Shift</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- modal edit Shift  -->
    <div class="modal fade" id="modalEditShift">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="formEditShift">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Shift</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <input type="hidden" name="shift_id" id="edit_shift_id">
                        <div class="mb-3">
                            <label>Worker</label>
                            <select name="user_id" id="edit_user_id" class="form-control select2" required>
                              <option value="">Select Worker</option>
                                <?php foreach($workers as $w): ?>
                                    <option value="<?= $w['id'] ?>">
                                        <?= esc($w['name']) ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label>Start</label>
                                <input type="time" name="start_time" id="edit_start_time" class="form-control" required>
                            </div>
                            <div class="col">
                                <label>End</label>
                                <input type="time" name="end_time" id="edit_end_time" class="form-control" required>
                            </div>
                        </div>
                        <div class="mt-3">
                            <label>Shift Type</label>
                            <select name="shift_type" id="edit_shift_type" class="form-control">
                                <option value="regular">Regular</option>
                                <option value="overtime">Overtime</option>
                                <option value="leave">Leave</option>
                                <option value="off">Off</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary">Update Shift</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<?= $this->endSection() ?>


<?= $this->section('scripts') ?>

<!-- DataTables -->
<link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css') ?>" />
<link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css') ?>" />
<link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css') ?>" />

<script src="<?= base_url('assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js') ?>"></script>

<script>
    'use strict';

    $(function () {
        let currentPlanId = null;
        let dt_table = $('.dtSchedule'),
            dt_schedule;
        if (dt_table.length) {
            dt_schedule = dt_table.DataTable({
                processing: true,
                serverSide: true,
                responsive: true,
                ajax: {
                    url: "<?= base_url('admin/schedules/datatable') ?>",
                    type: "POST",
                    data: function (d) {
                        d['<?= csrf_token() ?>'] = '<?= csrf_hash() ?>';
                    }
                },
                columns: [
                    { data: null },
                    { data: 'no' },
                    { data: 'department' },
                    { data: 'month' },
                    { data: 'year' },
                    { data: 'status' },
                    { data: 'requester' },
                    { data: 'created_at' },
                    { data: 'action' }
                ],
                columnDefs: [
                    {
                        className: 'control',
                        orderable: false,
                        searchable: false,
                        responsivePriority: 2,
                        targets: 0,
                        render: function () { return ''; }
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
                order: [[4, 'desc'], [3, 'desc']], // year desc, month desc
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
                        className: 'btn btn-label-primary dropdown-toggle me-2 waves-effect waves-light',
                        text: '<i class="ti ti-file-export me-sm-1"></i> <span class="d-none d-sm-inline-block">Export</span>',
                        buttons: [
                            { extend: 'print', className: 'dropdown-item' },
                            { extend: 'csv', className: 'dropdown-item' },
                            { extend: 'excel', className: 'dropdown-item' },
                            { extend: 'pdf', className: 'dropdown-item' }
                        ]
                    },
                    {
                        text: '<i class="ti ti-plus me-sm-1"></i> <span>Create Schedule</span>',
                        className: 'btn btn-primary waves-effect waves-light',
                        action: function () {
                            $('#modalAddSchedule').modal('show');
                        }
                    }
                ],
                responsive: {
                    details: {
                        display: $.fn.dataTable.Responsive.display.modal({
                            header: function (row) {
                                let data = row.data();
                                return 'Schedule Detail - ' + data.department;
                            }
                        }),
                        type: 'column',
                        renderer: function (api, rowIdx, columns) {
                            let data = $.map(columns, function (col) {
                                return col.title !== ''
                                    ? '<tr><td>' + col.title + ':</td><td>' + col.data + '</td></tr>'
                                    : '';
                            }).join('');

                            return data
                                ? $('<table class="table"><tbody /></table>').append(data)
                                : false;
                        }
                    }
                }
            });

            $('div.head-label').html('<h5 class="card-title mb-0">Schedule Plans</h5>');
        }

        function getShiftColor(type){
            switch(type){
                case 'regular': return 'success';
                case 'off': return 'secondary';
                case 'leave': return 'warning';
                case 'overtime': return 'danger';
                default: return 'info';
            }
        }

        function formatDate(dateStr){
            const d = new Date(dateStr);
            return d.toLocaleDateString('en-GB', { day:'2-digit', month:'short', year:'numeric' });
        }

        // ==========================
        // CREATE SCHEDULE (AJAX)
        // ==========================
        $('#formAddSchedule').on('submit', function (e) {
            e.preventDefault();

            let formData = new FormData(this);
            formData.append('<?= csrf_token() ?>', '<?= csrf_hash() ?>');

            Swal.fire({
                title: 'Submit schedule?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Yes, submit',
                reverseButtons: true
            }).then(result => {

                if (result.isConfirmed) {

                    $.ajax({
                        url: "<?= base_url('admin/schedules/store') ?>",
                        type: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        dataType: 'json',
                        success: function (res) {

                            if (res.status) {

                                Swal.fire({
                                    icon: 'success',
                                    title: 'Success',
                                    text: res.message,
                                    timer: 1500,
                                    showConfirmButton: false
                                });

                                $('#modalAddSchedule').modal('hide');
                                dt_schedule.ajax.reload(null, false);

                            } else {
                                Swal.fire('Failed', res.message, 'error');
                            }

                        },
                        error: function () {
                            Swal.fire('Error', 'Server error', 'error');
                        }
                    });
                }
            });
        });

        // ==========================
        // SUBMIT (AJAX)
        // ==========================
        $(document).on('click', '.btn-submit', function () {
            let id = $(this).data('id');
            Swal.fire({
                title: 'Submit schedule?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, submit',
                reverseButtons: true
            }).then(result => {
                if (result.isConfirmed) {
                    $.post("<?= base_url('admin/schedules/submit-schedule') ?>", {
                        id: id,
                        '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
                    }, function (res) {
                        if (res.status) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Schedule Submitted',
                                timer: 1500,
                                showConfirmButton: false
                            });
                            dt_schedule.ajax.reload(null, false);
                        } else {
                            Swal.fire('Failed', res.message, 'error');
                        }
                    }, 'json');
                }
            });
        });

        // ==========================
        // REQUEST REVISION (AJAX)
        // ==========================
        $(document).on('click', '.btn-revision', function () {
            let id = $(this).data('id');
            Swal.fire({
                title: 'Request revision?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, submit',
                reverseButtons: true
            }).then(result => {
                if (result.isConfirmed) {
                    $.post("<?= base_url('admin/schedules/request-revision') ?>", {
                        id: id,
                        '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
                    }, function (res) {
                        if (res.status) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Revision Submitted',
                                timer: 1500,
                                showConfirmButton: false
                            });
                            dt_schedule.ajax.reload(null, false);
                        } else {
                            Swal.fire('Failed', res.message, 'error');
                        }

                    }, 'json');
                }
            });
        });

        // ==========================
        // VIEW SCHEDULE (AJAX)
        // ==========================
        $(document).on('click', '.btn-view', function () {
            let id = $(this).data('id');
            currentPlanId = id;
            $('#modalViewSchedule').modal('show');
            loadScheduleDetail(id);
        });

        function loadScheduleDetail(id){
            $('#view_schedule_body').html(
                '<tr><td colspan="3" class="text-center">Loading...</td></tr>'
            );

            $.post("<?= base_url('admin/schedules/get-detail') ?>", {
                id: id,
                '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
            }, function (res) {
                if (res.status) {
                    $('#view_department').text(res.data.department);
                    $('#view_month').text(res.data.month_name);
                    $('#view_year').text(res.data.year);
                    $('#view_status').html(res.data.status_badge);
                    let isApproved = res.data.status_raw === 'approved';
                    let rows = '';
                    if (res.details.length > 0) {
                        res.details.forEach(function (day) {
                            if (!day.shifts || day.shifts.length === 0) {
                                rows += `
                                <tr>
                                    <td>${formatDate(day.shift_date)}</td>
                                    <td>-</td>
                                    <td>
                                        ${!isApproved ? `<span class="badge bg-label-secondary">NO SHIFT</span>` : ''}
                                        ${!isApproved ? `
                                        <button class="btn btn-sm btn-primary ms-2 btn-assign"
                                            data-plan="${id}"
                                            data-date="${day.shift_date}">
                                            Assign
                                        </button>` : ''}
                                    </td>
                                </tr>`;
                            } else {
                                day.shifts.forEach(function (shift) {
                                    rows += `
                                    <tr>
                                        <td>${formatDate(day.shift_date)}</td>
                                        <td>${shift.worker_name}</td>
                                        <td>
                                            <span class="badge bg-label-${getShiftColor(shift.shift_type)}">
                                                ${shift.shift_type.toUpperCase()}
                                            </span>
                                            <div class="small text-muted">
                                                ${shift.start_time} - ${shift.end_time}
                                            </div>

                                            ${!isApproved ? `
                                            <button class="btn btn-xs btn-outline-primary ms-2 btn-assign"
                                                data-plan="${id}" data-date="${day.shift_date}">
                                                <i class="ti ti-plus"></i>
                                            </button>

                                            <button class="btn btn-xs btn-outline-warning ms-2 btn-edit-shift"
                                                data-id="${shift.id}"
                                                data-user="${shift.user_id}"
                                                data-start="${shift.start_time}"
                                                data-end="${shift.end_time}"
                                                data-type="${shift.shift_type}">
                                                <i class="ti ti-pencil"></i>
                                            </button>

                                            <button class="btn btn-xs btn-outline-danger ms-2 btn-delete-shift"
                                                data-id="${shift.id}">
                                                <i class="ti ti-trash"></i>
                                            </button>
                                            ` : ''}
                                        </td>
                                    </tr>`;
                                });
                            }
                        });

                    } else {
                        rows = '<tr><td colspan="3" class="text-center">No schedule detail</td></tr>';
                    }
                    $('#view_schedule_body').html(rows);
                } else {
                    $('#view_schedule_body').html(
                        '<tr><td colspan="3" class="text-center text-danger">Failed to load</td></tr>'
                    );
                }
            }, 'json');
        }

        $(document).on('click', '.btn-assign', function(){
            let planId = $(this).data('plan');
            let date   = $(this).data('date');
            $('#assign_plan_id').val(planId);
            $('#assign_shift_date').val(date);
            $('#modalAssignShift').modal('show');
        });

        $('#formAssignShift').on('submit', function(e){
            e.preventDefault();
            let formData = $(this).serialize();
            $.post("<?= base_url('admin/schedules/assign-shift') ?>",
                formData + '&<?= csrf_token() ?>=<?= csrf_hash() ?>',
                function(res){
                    if(res.status){
                        $('#modalAssignShift').modal('hide');
                        Swal.fire({
                            icon: 'success',
                            title: 'Shift Assigned',
                            timer: 1200,
                            showConfirmButton: false
                        });
                        $('.btn-view[data-id="'+$('#assign_plan_id').val()+'"]').click();
                    } else {
                        Swal.fire('Error', res.message, 'error');
                    }
                }, 'json');
        });

        // OPEN EDIT MODAL
        $(document).on('click', '.btn-edit-shift', function(){
            $('#edit_shift_id').val($(this).data('id'));
            $('#edit_user_id').val($(this).data('user')).trigger('change');
            $('#edit_start_time').val($(this).data('start'));
            $('#edit_end_time').val($(this).data('end'));
            $('#edit_shift_type').val($(this).data('type'));
            $('#modalEditShift').modal('show');
        });

        // SUBMIT EDIT
        $('#formEditShift').on('submit', function(e){
            e.preventDefault();
            let formData = $(this).serialize();
            $.post("<?= base_url('admin/schedules/update-shift') ?>",
            formData + '&<?= csrf_token() ?>=<?= csrf_hash() ?>',
            function(res){
                if(res.status){
                    $('#modalEditShift').modal('hide');
                    Swal.fire({
                        icon: 'success',
                        title: 'Shift Updated',
                        timer: 1200,
                        showConfirmButton: false
                    });
                    if(currentPlanId){
                        loadScheduleDetail(currentPlanId);
                    }
                } else {
                    Swal.fire('Error', res.message, 'error');
                }
            }, 'json');
        });

        // OPEN DELETE MODAL
        $(document).on('click', '.btn-delete-shift', function(){
            let id = $(this).data('id');
            Swal.fire({
                title: 'Delete this shift?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, delete',
                reverseButtons: true
            }).then(result => {
                if(result.isConfirmed){
                    $.post("<?= base_url('admin/schedules/delete-shift') ?>", {
                        id: id,
                        '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
                    }, function(res){
                        if(res.status){
                            Swal.fire({
                                icon: 'success',
                                title: 'Shift Deleted',
                                timer: 1200,
                                showConfirmButton: false
                            });
                            if(currentPlanId){
                                loadScheduleDetail(currentPlanId);
                            }
                        } else {
                            Swal.fire('Error', res.message, 'error');
                        }
                    }, 'json');
                }
            });
        });
    });
</script>

<?= $this->endSection() ?>