						<?= $this->extend('layouts/main') ?>
						<?= $this->section('content') ?>

						<div class="container-xxl flex-grow-1 container-p-y">
						    <div class="card">
						        <div class="card-datatable table-responsive pt-0">
						            <table class="dtManpower table table-striped">
						                <thead>
						                    <tr>
						                        <th></th>
						                        <th>No.</th>
						                        <th>Position</th>
						                        <th>Needed</th>
						                        <th>Reason</th>
						                        <th>HRM Acc</th>
						                        <th>GM Acc</th>
						                        <th>Status</th>
						                        <th>Created At</th>
						                        <th>Action</th>
						                    </tr>
						                </thead>
						            </table>
						        </div>

								<!-- edit modal form -->
				                <div class="modal fade" id="modalEditAcc" tabindex="-1" aria-hidden="true">
									<div class="modal-dialog modal-lg modal-dialog-centered">
									    <div class="modal-content">
										    <form id="formEditAcc" enctype="multipart/form-data">
										        <div class="modal-header">
										          	<h5 class="modal-title">Approval Request</h5>
										          	<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
										        </div>

										        <div class="modal-body">
										          	<input type="hidden" name="id" id="edit_id">
										          	<div class="row">
								                        <div class="col-md-6 mb-3">
								                            <label class="form-label" for="edit_job_position">Job Position</label>
								                        	<select
															    name="position"
															    id="edit_job_position"
															    class="form-select"
															    data-placeholder="Select Jobs"
															    style="width:100%" disabled>
															    <option value=""></option>
															    <?php foreach ($skills as $skill): ?>
															        <option value="<?= $skill['id'] ?>">
															            <?= esc($skill['name']) ?>
															        </option>
															    <?php endforeach; ?>
															</select>
								                        </div>
								                        <div class="col-md-6 mb-3">
								                            <label class="form-label">Total Worker</label>
								                        	<input type="text" class="form-control" name="tot_worker" id="edit_tot_worker" disabled>
								                        </div>
								                    </div>
								                    <div class="row">
								                    	<div class="col-md-12 mb-6">
								                            <label class="form-label">Reason</label>
										            		<textarea class="form-control" name="reason" id="edit_reason" rows="3" disabled></textarea>
								                        </div>
								                    </div>
								                    <div class="row">
								                        <div class="col-md-12 mb-6">
								                            <label class="form-label" for="edit_persetujuan">Appoval</label>
								                        	<select name="persetujuan" id="edit_persetujuan" class="form-control" required>
								                            	<option value="">Select Approval</option>
							                                    <option value="yes">Approve</option>
							                                    <option value="no">Reject</option>
							                                </select>
								                        </div>
								                    </div>
								                    <div class="row">
								                    	<div class="col-md-12 mb-6">
								                            <label class="form-label">Note</label>
										            		<textarea class="form-control" name="catatan" id="edit_catatan" rows="3"></textarea>
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
							// DataTables Users
						    'use strict';
						    $(function () {
						        let dt_tableManpower = $('.dtManpower'), dt_manpower;
						        if (dt_tableManpower.length) {
						        	dt_manpower = dt_tableManpower.DataTable({
						        		processing: true,
					                	serverSide: true,
					                	responsive: true,
						                ajax: {
						                    url: "<?= base_url('admin/manpoweracc/datatable') ?>",
						                    type: "POST",
						                    data: d => {
						                        d['<?= csrf_token() ?>'] = '<?= csrf_hash() ?>';
						                    }
						                },
						                columns: [
						                    { data: null },          // responsive control
						                    { data: 'no_urut' },
						                    { data: 'position' },
						                    { data: 'mp_needed' },
						                    { data: 'reason' },
						                    { data: 'hrm_approval' },
						                    { data: 'gm_approval' },
						                    { data: 'status_mp' },
						                    { data: 'created' },
						                    { data: 'action' }       // actions (HTML from backend)
						                ],
						                columnDefs: [
						                    {
						                        // Responsive control
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
					                    		// Posisi yang dibutuhkan
								          		targets: 2,
								          		responsivePriority: 1,
								        	},
						                    {
						                        // Actions
						                        targets: -1,
						                        title: 'Actions',
						                        orderable: false,
						                        searchable: false
						                    }
					                	],
					                	order: [[2, 'asc']],
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
						                                exportOptions: { columns: [1,2,3,4,5,6,7,8] }
						                            },
						                            {
						                                extend: 'csv',
						                                text: '<i class="ti ti-file-text me-1"></i>Csv',
						                                className: 'dropdown-item',
						                                exportOptions: { columns: [1,2,3,4,5,6,7,8] }
						                            },
						                            {
						                                extend: 'pdf',
						                                text: '<i class="ti ti-file-description me-1"></i>Pdf',
						                                className: 'dropdown-item',
						                                exportOptions: { columns: [1,2,3,4,5,6,7,8] }
						                            }
						                        ]
						                    }
						                ],
						                responsive: {
						                    details: {
						                        display: $.fn.dataTable.Responsive.display.modal({
						                            header: function (row) {
						                                let data = row.data();
						                                return 'Details of ' + data.position;
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
									$('div.head-label').html('<h5 class="card-title mb-0">Approvals List</h5>');
						        }
						    });

							// Submit form approve data
							$(document).on('click', '.btn-approve', function () {
						        const id = $(this).data('id');
						        $.post("<?= base_url('admin/manpoweracc/get') ?>", {
						            id: id,
						            '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
						        }, function (res) {

						            if (!res.status) {
						                Swal.fire('Error', res.message, 'error');
						                return;
						            }

						            const d = res.data;
						            $('#edit_id').val(d.id);
						            $('#edit_job_position').val(d.position_id);
						            $('#edit_tot_worker').val(d.manpower_needed);
						            $('#edit_reason').val(d.reason);
						            $('#modalEditAcc').modal('show');
						        }, 'json');
						    });

							$('#formEditAcc').on('submit', function (e) {
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
									        url: "<?= base_url('admin/manpoweracc/acc') ?>",
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

									                $('#modalEditAcc').modal('hide');
									                $('.dtManpower').DataTable().ajax.reload(null, false);
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

							// Reset form approve jika di tutup
						    $('#modalEditAcc').on('hidden.bs.modal', function () {
							    const $form = $('#formEditAcc');

							    // reset form native
							    $form[0].reset();
							});
						</script>
						<?= $this->endSection() ?>