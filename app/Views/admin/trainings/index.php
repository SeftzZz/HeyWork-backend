<?= $this->extend('layouts/main') ?>
<?= $this->section('content') ?>

<div class="container-xxl flex-grow-1 container-p-y">

    <div class="card">
        <div class="card-datatable table-responsive pt-0">
            <table class="dtTraining table table-striped">
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
    <!-- CREATE TRAINING MODAL -->
    <!-- ========================= -->
    <div class="modal fade" id="modalAddTraining" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-md modal-dialog-centered">
            <div class="modal-content">

                <form id="formAddTraining">

                    <div class="modal-header">
                        <h5 class="modal-title">Create Training Plan</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">

                        <?php $userRole = session()->get('user_role'); ?>

                        <div class="row">

                            <?php if(in_array($userRole, ['admin','hotel_hr'])): ?>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Department</label>
                                <select name="department" class="form-select" required>
                                    <option value="">Select Department</option>
                                    <option value="Front Office">Front Office</option>
                                    <option value="Housekeeping">Housekeeping</option>
                                    <option value="Food & Beverage Service">Food & Beverage Service</option>
                                    <option value="Kitchen / Culinary">Kitchen / Culinary</option>
                                    <option value="Human Resources">Human Resources</option>
                                </select>
                            </div>
                            <?php endif; ?>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Training Title</label>
                                <input type="text" name="title" class="form-control" required>
                            </div>

                        </div>


                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3"
                            placeholder="Training description (optional)"></textarea>
                        </div>


                        <div class="mb-3">
                            <label class="form-label">Trainer</label>
                            <select name="trainer_id" class="form-select">
                                <option value="">Select Trainer</option>

                                <?php foreach($trainers as $trainer): ?>
                                    <option value="<?= $trainer['id'] ?>">
                                        <?= esc($trainer['name']) ?>
                                    </option>
                                <?php endforeach; ?>

                            </select>
                        </div>


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

                                    <?php for($y=date('Y')-1; $y<=date('Y')+2; $y++): ?>

                                        <option value="<?= $y ?>" <?= $y == date('Y') ? 'selected' : '' ?>>

                                            <?= $y ?>

                                        </option>

                                    <?php endfor; ?>

                                </select>
                            </div>

                        </div>

                    </div>

                    <div class="modal-footer">

                        <button type="button"
                                class="btn btn-label-secondary"
                                data-bs-dismiss="modal">
                            Cancel
                        </button>

                        <button type="submit"
                                class="btn btn-primary">
                            Submit
                        </button>

                    </div>

                </form>

            </div>
        </div>
    </div>

    <!-- ========================= -->
    <!-- VIEW TRAINING MODAL -->
    <!-- ========================= -->
    <div class="modal fade" id="modalViewTraining" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Training Detail</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <!-- HEADER -->
                    <div class="row mb-3">

                        <div class="col-md-4">
                            <strong>Title:</strong>
                            <div id="view_title"></div>
                        </div>

                        <div class="col-md-3">
                            <strong>Department:</strong>
                            <div id="view_department"></div>
                        </div>

                        <div class="col-md-2">
                            <strong>Status:</strong>
                            <div id="view_status"></div>
                        </div>

                    </div>

                    <hr>

                    <!-- PARTICIPANT TABLE -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-sm">
                            <thead class="table-light">
                                <tr>
                                    <th>Date</th>
                                    <th>Participant</th>
                                    <th>Status</th>
                                </tr>
                            </thead>

                            <tbody id="view_training_body">
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


    <!-- ========================= -->
    <!-- ASSIGN PARTICIPANT -->
    <!-- ========================= -->
    <div class="modal fade" id="modalAssignParticipant">

        <div class="modal-dialog">
            <div class="modal-content">

                <form id="formAssignParticipant">

                    <div class="modal-header">
                        <h5 class="modal-title">Assign Participant</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">

                        <input type="hidden" name="training_day_id" id="assign_training_day_id">
                        <input type="hidden" name="training_date" id="assign_training_date">

                        <div class="mb-3">
                            <label>Worker</label>

                            <select name="user_id" class="form-control select2" required>

                                <option value="">Select Worker</option>

                                <?php foreach ($workers as $w) : ?>
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

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-primary">
                            Save
                        </button>
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

        let dt_table = $('.dtTraining'),
            dt_training;

        if (dt_table.length) {

            dt_training = dt_table.DataTable({
                processing: true,
                serverSide: true,
                responsive: true,
                ajax: {
                    url: "<?= base_url('admin/trainings/datatable') ?>",
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
                        text: '<i class="ti ti-plus me-sm-1"></i> <span>Create Training</span>',
                        className: 'btn btn-primary waves-effect waves-light',
                        action: function () {
                            $('#modalAddTraining').modal('show');
                        }
                    }
                ],
                responsive: {
                    details: {
                        display: $.fn.dataTable.Responsive.display.modal({
                            header: function (row) {
                                let data = row.data();
                                return 'Training Detail - ' + data.department;
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

            $('div.head-label').html('<h5 class="card-title mb-0">Training Plans</h5>');
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
        // CREATE TRAINING
        // ==========================

        $('#formAddTraining').on('submit', function (e) {
            e.preventDefault();

            let formData = new FormData(this);
            formData.append('<?= csrf_token() ?>', '<?= csrf_hash() ?>');

            Swal.fire({
                title: 'Submit Training?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Yes, submit',
                reverseButtons: true
            }).then(result => {

                if (result.isConfirmed) {

                    $.ajax({
                        url: "<?= base_url('admin/trainings/store') ?>",
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

                                $('#modalAddTraining').modal('hide');
                                dt_training.ajax.reload(null, false);

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
        // REQUEST REVISION
        // ==========================

        $(document).on('click', '.btn-revision', function () {

            let id = $(this).data('id');

            Swal.fire({

                title: 'Request revision?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes submit'

            }).then(result => {

                if (result.isConfirmed) {

                    $.post("<?= base_url('admin/trainings/request-revision') ?>", {

                        id: id,
                        '<?= csrf_token() ?>': '<?= csrf_hash() ?>'

                    }, function (res) {

                        if (res.status) {

                            Swal.fire({
                                icon: 'success',
                                title: 'Revision submitted',
                                timer: 1500,
                                showConfirmButton: false
                            });

                            dt_training.ajax.reload(null, false);

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

            $('#modalViewTraining').modal('show');
            $('#view_training_body').html(
                '<tr><td colspan="3" class="text-center">Loading...</td></tr>'
            );

            $.post("<?= base_url('admin/trainings/get-detail') ?>", {
                id: id,
                '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
            }, function (res) {

                if (res.status) {

                    // Header
                    $('#view_title').text(res.data.title);
                    $('#view_department').text(res.data.department);
                    $('#view_month').text(res.data.month_name);
                    $('#view_year').text(res.data.year);
                    $('#view_status').html(res.data.status_badge);

                    // Detail rows
                    let rows = '';

                    if (res.details.length > 0) {

                        res.details.forEach(function (day) {

                            // Tidak ada shift
                            if (!day.shifts || day.shifts.length === 0) {

                                rows += `
                                <tr>
                                    <td>${formatDate(day.training_date)}</td>
                                    <td>-</td>
                                    <td>
                                        <span class="badge bg-label-secondary">NO SHIFT</span>
                                        <button 
                                            class="btn btn-sm btn-primary ms-2 btn-assign"
                                            data-plan="${id}"
                                            data-date="${day.training_date}">
                                            Assign
                                        </button>
                                    </td>
                                </tr>
                                `;

                            } else {

                                day.shifts.forEach(function (shift) {

                                    rows += `
                                    <tr>
                                        <td>${formatDate(day.training_date)}</td>
                                        <td>${shift.worker_name}</td>
                                        <td>
                                            <span class="badge bg-label-${getShiftColor(shift.shift_type)}">
                                                ${shift.shift_type.toUpperCase()}
                                            </span>
                                            <div class="small text-muted">
                                                ${shift.start_time} - ${shift.end_time}
                                            </div>
                                            <button 
                                                class="btn btn-sm btn-outline-primary ms-2 btn-assign"
                                                data-plan="${id}"
                                                data-date="${day.training_date}">
                                                + Add
                                            </button>
                                        </td>
                                    </tr>
                                    `;
                                });

                            }

                        });

                    } else {

                        rows = '<tr><td colspan="3" class="text-center">No schedule detail</td></tr>';
                    }

                    $('#view_training_body').html(rows);

                } else {
                    $('#view_training_body').html(
                        '<tr><td colspan="3" class="text-center text-danger">Failed to load</td></tr>'
                    );
                }

            }, 'json');
        });


        // ==========================
        // ASSIGN PARTICIPANT
        // ==========================

        $(document).on('click', '.btn-assign', function(){

            let planId = $(this).data('plan');
            let date   = $(this).data('date');

            $('#assign_training_day_id').val(planId);
            $('#assign_training_date').val(date);
            $('#modalAssignParticipant').modal('show');

        });


        $('#formAssignParticipant').on('submit', function(e){

            e.preventDefault();

            let formData = $(this).serialize();

            $.post("<?= base_url('admin/trainings/assign-participant') ?>",

                formData + '&<?= csrf_token() ?>=<?= csrf_hash() ?>',

                function(res){

                    if(res.status){

                        $('#modalAssignParticipant').modal('hide');

                        Swal.fire({
                            icon: 'success',
                            title: 'Participant assigned',
                            timer: 1200,
                            showConfirmButton: false
                        });

                        $('.btn-view[data-id="'+$('#assign_training_day_id').val()+'"]').click();

                    } else {

                        Swal.fire('Error', res.message, 'error');

                    }

                }, 'json');

        });

    });
</script>
<?= $this->endSection() ?>