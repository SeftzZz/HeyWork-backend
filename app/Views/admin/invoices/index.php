            <?= $this->extend('layouts/main') ?>
            <?= $this->section('content') ?>
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="card">
                    <div class="card-datatable table-responsive pt-0">
                        <table class="dtInvoice table table-striped">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>No.</th>
                                    <th>Invoice</th>
                                    <th>Hotel</th>
                                    <th>Week</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                        </table>
                    </div>

                    <!-- modal view -->
                    <div class="modal fade" id="modalInvoice" tabindex="-1">
                        <div class="modal-dialog modal-xl modal-dialog-scrollable">
                            <div class="modal-content" id="modalInvoiceContent"></div>
                        </div>
                    </div>

                    <!-- edit modal form -->
                    <div class="modal fade" id="modalEditInv" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <form id="formEditInv" enctype="multipart/form-data">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Invoice</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>

                                    <div class="modal-body">
                                        <input type="hidden" name="id" id="edit_id">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Invoice</label>
                                                <input type="text" class="form-control" name="noinvoice" id="edit_noinv" disabled>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Hotel</label>
                                                <input type="text" class="form-control" name="hotel" id="edit_hotel" disabled>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Week</label>
                                                <input type="text" class="form-control" name="week" id="edit_week" disabled>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Amount</label>
                                                <input type="text" class="form-control" name="amount" id="edit_amount" disabled>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 mb-3">
                                                <label class="form-label" for="edit_status">Status</label>
                                                <select name="status" id="edit_status" class="form-control required">
                                                    <option value="unpaid">Unpaid</option>
                                                    <option value="paid">Paid</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <?= $this->endSection() ?>

            <?= $this->section('scripts') ?>
                <!-- DataTables -->
                <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css') ?>" />
                <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css') ?>" />
                <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-checkboxes-jquery/datatables.checkboxes.css') ?>" />
                <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css') ?>" />

                <script src="<?= base_url('assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js') ?>"></script>

                <script>
                    'use strict';
                    $(function () {
                        let dt_tableInvoice = $('.dtInvoice'),
                        dt_invoice;
                        if (dt_tableInvoice.length) {
                            dt_invoice = dt_tableInvoice.DataTable({
                                processing: true,
                                serverSide: true,
                                responsive: true,
                                ajax: {
                                    url: "<?= base_url('admin/invoices/datatable') ?>",
                                    type: "POST",
                                    data: d => {
                                        d['<?= csrf_token() ?>'] = '<?= csrf_hash() ?>';
                                    }
                                },
                                columns: [
                                    { data: null },
                                    { data: 'no_urut' },
                                    { data: 'invoice_number' },
                                    { data: 'hotel' },
                                    { data: 'week' },
                                    { data: 'amount' },
                                    { data: 'status' },
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
                                        render: function () {
                                            return '';
                                        }
                                    },
                                    {
                                        targets: 1,
                                        orderable: false,
                                        searchable: false
                                    },
                                    {
                                        targets: 2,
                                        responsivePriority: 1
                                    },
                                    {
                                        targets: -1,
                                        title: 'Actions',
                                        orderable: false,
                                        searchable: false
                                    }
                                ],
                                order: [[7, 'desc']],
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
                                            {
                                                extend: 'print',
                                                text: '<i class="ti ti-printer me-1"></i>Print',
                                                className: 'dropdown-item',
                                                exportOptions: { columns: [1,2,3,4,5,6] }
                                            },
                                            {
                                                extend: 'csv',
                                                text: '<i class="ti ti-file-text me-1"></i>Csv',
                                                className: 'dropdown-item',
                                                exportOptions: { columns: [1,2,3,4,5,6] }
                                            },
                                            {
                                                extend: 'pdf',
                                                text: '<i class="ti ti-file-description me-1"></i>Pdf',
                                                className: 'dropdown-item',
                                                exportOptions: { columns: [1,2,3,4,5,6] }
                                            }
                                        ]
                                    }
                                ],
                                responsive: {
                                    details: {
                                        display: $.fn.dataTable.Responsive.display.modal({
                                            header: function (row) {
                                                let data = row.data();
                                                return 'Invoice ' + data.invoice_number;
                                            }
                                        }),
                                        type: 'column',

                                        renderer: function (api, rowIdx, columns) {
                                            let data = $.map(columns, function (col) {
                                                return col.title !== ''
                                                    ? '<tr>' +
                                                        '<td>' + col.title + ':</td>' +
                                                        '<td>' + col.data + '</td>' +
                                                      '</tr>'
                                                    : '';
                                            }).join('');
                                            return data
                                                ? $('<table class="table"><tbody /></table>').append(data)
                                                : false;
                                        }
                                    }
                                }
                            });
                            $('div.head-label').html('<h5 class="card-title mb-0">Invoices List</h5>');
                        }
                    });

                    $(document).on('click','.btn-view-invoice',function(){
                        let id = $(this).data('id');
                        $('#modalInvoiceContent').html(`
                            <div class="modal-body text-center p-5">
                                <div class="spinner-border"></div>
                            </div>
                        `);

                        $('#modalInvoice').modal('show');

                        $.get("<?= base_url('admin/invoices/view') ?>/" + id, function(res){
                            $('#modalInvoiceContent').html(res);
                        });
                    });

                    $('#modalEditInv').on('hidden.bs.modal', function () {
                        // reset form
                        $('#formEditInv')[0].reset();
                    });

                    // Submit form edit data
                    $(document).on('click', '.btn-edit', function () {
                        const id = $(this).data('id');
                        $.post("<?= base_url('admin/invoices/get') ?>", {
                            id: id,
                            '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
                        }, function (res) {
                            if (!res.status) {
                                Swal.fire('Error', res.message, 'error');
                                return;
                            }

                            const d = res.data;
                            $('#modalEditInv').modal('show');
                            setTimeout(function () {
                                $('#edit_id').val(d.id);
                                $('#edit_noinv').val(d.invoice_number);
                                $('#edit_hotel').val(d.hotel_name);
                                $('#edit_week').val(d.week_key);
                                $('#edit_amount').val(d.total_amount);
                                $('#edit_status').val(d.status);
                            }, 200);
                        }, 'json');
                    });

                    $('#formEditInv').on('submit', function (e) {
                        e.preventDefault();
                        let formData = new FormData(this);
                        formData.append('<?= csrf_token() ?>', '<?= csrf_hash() ?>');
                        Swal.fire({
                            title: 'Are you sure?',
                            icon: 'question',
                            showCancelButton: true,
                            showDenyButton: false,
                            confirmButtonText: 'Yes, update',
                            cancelButtonText: 'No',
                            reverseButtons: true
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $.ajax({
                                    url: "<?= base_url('admin/invoices/update') ?>",
                                    type: "POST",
                                    data: formData,
                                    processData: false,
                                    contentType: false,
                                    dataType: 'json',
                                    success: function (res) {
                                        if (res.status) {
                                            Swal.fire({
                                                icon: 'success',
                                                title: 'Succeed',
                                                text: res.message,
                                                timer: 1500,
                                                showConfirmButton: false
                                            });

                                            $('#modalEditInv').modal('hide');
                                            $('.dtInvoice').DataTable().ajax.reload(null, false);
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
                </script>
            <?= $this->endSection() ?>