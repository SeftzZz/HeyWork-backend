<?= $this->extend('layouts/main') ?>
<?= $this->section('content') ?>

<div class="container-xxl flex-grow-1 container-p-y">

    <h4 class="fw-bold mb-4">Schedule Approvals</h4>

    <?php if(session()->getFlashdata('success')): ?>
        <div class="alert alert-success"><?= session()->getFlashdata('success') ?></div>
    <?php endif; ?>

    <?php if(session()->getFlashdata('error')): ?>
        <div class="alert alert-danger"><?= session()->getFlashdata('error') ?></div>
    <?php endif; ?>

    <!-- ===================== -->
    <!-- PENDING SCHEDULE PLANS -->
    <!-- ===================== -->

    <div class="card mb-4">
        <div class="card-header fw-bold">Pending Schedule Plans</div>
        <div class="card-body table-responsive">

            <table class="table table-bordered table-hover" id="planTable">
                <thead class="table-light">
                    <tr>
                        <th>Department</th>
                        <th>Month</th>
                        <th>Year</th>
                        <th>Requested By</th>
                        <th width="180">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($plans as $row): ?>
                        <tr>
                            <td><?= esc($row->department) ?></td>
                            <td><?= $row->month ?></td>
                            <td><?= $row->year ?></td>
                            <td><?= $row->requested_by ?></td>
                            <td>
                                <form method="post"
                                      action="<?= base_url('admin/schedule-approvals/approve-plan/'.$row->id) ?>"
                                      class="d-inline">
                                    <?= csrf_field() ?>
                                    <button class="btn btn-sm btn-success">
                                        <i class="ti ti-check"></i>
                                    </button>
                                </form>

                                <form method="post"
                                      action="<?= base_url('admin/schedule-approvals/reject-plan/'.$row->id) ?>"
                                      class="d-inline">
                                    <?= csrf_field() ?>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="ti ti-x"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

        </div>
    </div>

    <!-- ===================== -->
    <!-- PENDING REVISIONS -->
    <!-- ===================== -->

    <div class="card">
        <div class="card-header fw-bold">Pending Schedule Revisions</div>
        <div class="card-body table-responsive">

            <table class="table table-bordered table-hover" id="revisionTable">
                <thead class="table-light">
                    <tr>
                        <th>Plan ID</th>
                        <th>Revision No</th>
                        <th>Requested By</th>
                        <th>Created At</th>
                        <th width="180">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($revisions as $row): ?>
                        <tr>
                            <td><?= $row->schedule_plan_id ?></td>
                            <td><?= $row->revision_number ?></td>
                            <td><?= $row->requested_by ?></td>
                            <td><?= date('d M Y H:i', strtotime($row->created_at)) ?></td>
                            <td>
                                <form method="post"
                                      action="<?= base_url('admin/schedule-approvals/approve-revision/'.$row->id) ?>"
                                      class="d-inline">
                                    <?= csrf_field() ?>
                                    <button class="btn btn-sm btn-success">
                                        <i class="ti ti-check"></i>
                                    </button>
                                </form>

                                <form method="post"
                                      action="<?= base_url('admin/schedule-approvals/reject-revision/'.$row->id) ?>"
                                      class="d-inline">
                                    <?= csrf_field() ?>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="ti ti-x"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

        </div>
    </div>

</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        $('#planTable').DataTable();
        $('#revisionTable').DataTable();
    });
</script>

<?= $this->endSection() ?>