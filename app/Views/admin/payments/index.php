						<?= $this->extend('layouts/main') ?>
						<?= $this->section('content') ?>

						<div class="container-xxl flex-grow-1 container-p-y">
						  <div class="card">
						    <div class="card-datatable table-responsive pt-0">
						      <table class="dtPayments table table-striped">
						        <thead>
						          <tr>
						            <th></th>
						            <th>No.</th>
						            <th>Hotels</th>
						            <th>Worker</th>
						            <th>Weeks</th>
						            <th>Working Days</th>
						            <th>Duration (Hours)</th>
						            <th>Amount</th>
						            <th>Action</th>
						          </tr>
						        </thead>
						        <tbody></tbody>
						      </table>
						    </div>
						  </div>
						</div>

						<?= $this->endSection() ?>

						<?= $this->section('scripts') ?>

						<link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css') ?>" />
						<link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css') ?>" />
						<link rel="stylesheet" href="<?= base_url('assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css') ?>" />

						<script src="<?= base_url('assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js') ?>"></script>

						<script>
						'use strict';

						$(function () {

						    let dt_table = $('.dtPayments'), dt_payments;

						    if (dt_table.length) {

						        dt_payments = dt_table.DataTable({
						            processing: true,
						            serverSide: true,
						            responsive: true,
						            ajax: {
						                url: "<?= base_url('admin/payments/datatable') ?>",
						                type: "POST",
						                data: d => {
						                    d['<?= csrf_token() ?>'] = '<?= csrf_hash() ?>';
						                }
						            },
						            columns: [
						                { data: null },
									    { data: 'no' },
									    { data: 'hotel' },
									    { data: 'worker' },
									    { data: 'job' },
									    { data: 'working_days' },
									    { data: 'duration' },
									    { data: 'amount' },
									    { data: 'action' }
						            ],
						            columnDefs: [
						                {
						                    className: 'control',
						                    orderable: false,
						                    searchable: false,
						                    targets: 0,
						                    render: function () { return ''; }
						                },
						                {
						                    targets: 1,
						                    orderable: false,
						                    searchable: false
						                }
						            ],
						            order: [[2, 'desc']],
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
						                    text: '<i class="ti ti-file-export me-sm-1"></i> Export',
						                    buttons: [
						                        { extend: 'print', className: 'dropdown-item' },
						                        { extend: 'csv', className: 'dropdown-item' },
						                        { extend: 'pdf', className: 'dropdown-item' }
						                    ]
						                }
						            ],
						            responsive: {
						                details: {
						                    display: $.fn.dataTable.Responsive.display.modal({
						                        header: function (row) {
						                            let data = row.data();
						                            return 'Payment Detail - ' + data.worker;
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

						        $('div.head-label').html('<h5 class="card-title mb-0">Payments List (Complete Attendance)</h5>');
						    }
						});
						</script>

						<?= $this->endSection() ?>