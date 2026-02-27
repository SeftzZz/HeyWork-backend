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
                              <div class="row">
                                <div class="col-lg-12 mb-4">
                                  <button id="exportReportBtn" class="btn btn-success">
                                    Export Full Report
                                  </button>
                                </div>

                                <!-- Productivity Ratio -->
                                <div class="col-lg-8 mb-4">
                                  <div class="card h-100">
                                    <div class="card-header pb-0 d-flex justify-content-between mb-lg-n4">
                                      <div class="card-title mb-0">
                                        <h5 class="mb-0">Productivity Ratio</h5>
                                        <small class="badge rounded bg-label-success">Weekly Earnings Overview</small>
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
                                              <h6 class="mb-0">Month To Date</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 end-balance-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar end-balance-progress"
                                                role="progressbar"
                                                style="width: 65%"
                                                aria-valuenow="65"
                                                aria-valuemin="0"
                                                aria-valuemax="100"></div>
                                            </div>
                                          </div>
                                          <div class="col-12 col-sm-4">
                                            <div class="d-flex gap-2 align-items-center">
                                              <h6 class="mb-0">Expense</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 expense-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar bg-danger expense-progress"
                                                role="progressbar"
                                                style="width: 65%"
                                                aria-valuenow="65"
                                                aria-valuemin="0"
                                                aria-valuemax="100"></div>
                                            </div>
                                          </div>
                                          <div class="col-12 col-sm-4">
                                            <div class="d-flex gap-2 align-items-center">
                                              <h6 class="mb-0">End Balance</h6>
                                            </div>
                                            <h4 class="my-2 pt-1 earning-value">0</h4>
                                            <div class="progress w-75" style="height: 4px">
                                              <div
                                                class="progress-bar bg-info earning-progress"
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
                                <div class="col-lg-4 mb-4">
                                  <div class="card">
                                    <div class="card-header d-flex justify-content-between pb-1">
                                      <h5 class="mb-0 card-title">Monthly Growth</h5>
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
                                    </div>
                                  </div>
                                </div>
                                <!--/ Productivity Ratio -->

                                <div class="col-lg-12 mb-4">
                                  <div class="nav-align-top mb-4">
                                    <ul class="nav nav-pills mb-3 nav-fill" role="tablist">
                                      <li class="nav-item">
                                        <button
                                          type="button"
                                          class="nav-link active"
                                          role="tab"
                                          data-bs-toggle="tab"
                                          data-bs-target="#navs-pills-justified-home"
                                          aria-controls="navs-pills-justified-home"
                                          aria-selected="true">
                                          <i class="tf-icons ti ti-user ti-xs me-1"></i> Daily Worker
                                          <span class="badge rounded-pill badge-center h-px-20 w-px-20 bg-danger ms-1">3</span>
                                        </button>
                                      </li>
                                      <li class="nav-item">
                                        <button
                                          type="button"
                                          class="nav-link"
                                          role="tab"
                                          data-bs-toggle="tab"
                                          data-bs-target="#navs-pills-justified-profile"
                                          aria-controls="navs-pills-justified-profile"
                                          aria-selected="false">
                                          <i class="tf-icons ti ti-building ti-xs me-1"></i> Corporate
                                        </button>
                                      </li>
                                      <li class="nav-item">
                                        <button
                                          type="button"
                                          class="nav-link"
                                          role="tab"
                                          data-bs-toggle="tab"
                                          data-bs-target="#navs-pills-justified-messages"
                                          aria-controls="navs-pills-justified-messages"
                                          aria-selected="false">
                                          <i class="tf-icons ti ti-users ti-xs me-1"></i> All
                                        </button>
                                      </li>
                                    </ul>
                                    <div class="tab-content">
                                      <div class="tab-pane fade show active" id="navs-pills-justified-home" role="tabpanel">
                                        <div class="row">
                                          <!-- Last day attendances -->
                                          <div class="col-lg-8 mb-4">
                                            <div class="card">
                                              <div class="card table-responsive pt-0">
                                                <table id="dailyWorkerTable" class="table table-bordered table-striped text-center">
                                                  <thead class="table-light">
                                                    <tr>
                                                      <th rowspan="2" class="text-start">Departement</th>
                                                      <th colspan="3">31-Jan-26</th>
                                                    </tr>
                                                    <tr>
                                                      <th>DW</th>
                                                      <th>COST</th>
                                                      <th>Total</th>
                                                    </tr>
                                                  </thead>
                                                  <tbody id="dailyWorkerBody"></tbody>
                                                </table>
                                              </div>
                                            </div>
                                          </div>

                                          <div class="col-lg-4 mb-4">
                                            <div id="dailyWorkerskillRatioContainer" class="mb-4"></div>
                                            <div class="card mb-4">
                                              <div class="card-header d-flex justify-content-between">
                                                <div class="card-title mb-0">
                                                  <h5 class="mb-0">Last day attendances</h5>
                                                  <small class="text-muted">8.52k Daily Worker</small>
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
                                          <!--/ Last day attendances -->
                                        </div>
                                      </div>
                                      <div class="tab-pane fade" id="navs-pills-justified-profile" role="tabpanel">
                                        <div class="row">
                                          <!-- Last day attendances -->
                                          <div class="col-lg-8 mb-4">
                                            <div class="card">
                                              <div class="card table-responsive pt-0">
                                                <table id="companyTable" class="table table-bordered table-striped text-center">
                                                  <thead class="table-light">
                                                    <tr>
                                                      <th rowspan="2" class="text-start">Departement</th>
                                                      <th colspan="3">31-Jan-26</th>
                                                    </tr>
                                                    <tr>
                                                      <th>CORPORATE</th>
                                                      <th>COST</th>
                                                      <th>Total</th>
                                                    </tr>
                                                  </thead>
                                                  <tbody id="companyBody"></tbody>
                                                </table>
                                              </div>
                                            </div>
                                          </div>

                                          <div class="col-lg-4 mb-4">
                                            <div id="corporateskillRatioContainer" class="mb-4"></div>
                                            <div class="card mb-4">
                                              <div class="card-header d-flex justify-content-between">
                                                <div class="card-title mb-0">
                                                  <h5 class="mb-0">Last day attendances</h5>
                                                  <small class="text-muted">8.52k Daily Worker</small>
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
                                          <!--/ Last day attendances -->
                                        </div>
                                      </div>
                                      <div class="tab-pane fade" id="navs-pills-justified-messages" role="tabpanel">
                                        <div class="row">
                                          <!-- Last day attendances -->
                                          <div class="col-lg-8 mb-4">
                                            <div class="card">
                                              <div class="card table-responsive pt-0">
                                                <table id="allTable" class="table table-bordered table-striped text-center">
                                                  <thead class="table-light">
                                                    <tr>
                                                      <th rowspan="2" class="text-start">Departement</th>
                                                      <th colspan="3">31-Jan-26</th>
                                                    </tr>
                                                    <tr>
                                                      <th>DW</th>
                                                      <th>COST</th>
                                                      <th>Total</th>
                                                    </tr>
                                                  </thead>
                                                  <tbody id="allBody"></tbody>
                                                </table>
                                              </div>
                                            </div>
                                          </div>

                                          <div class="col-lg-4 mb-4">
                                            <div id="allskillRatioContainer" class="mb-4"></div>
                                            <div class="card mb-4">
                                              <div class="card-header d-flex justify-content-between">
                                                <div class="card-title mb-0">
                                                  <h5 class="mb-0">Last day attendances</h5>
                                                  <small class="text-muted">8.52k Daily Worker</small>
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
                                          <!--/ Last day attendances -->
                                        </div>
                                      </div>
                                    </div>
                                  </div>
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

                            // ======================
                            // LABEL COLOR FUNCTION
                            // ======================
                            function getRatioBadgeClass(label) {

                              if (!label) return 'bg-label-secondary';

                              label = label.toUpperCase();

                              if (label === 'GOOD') return 'bg-label-success';
                              if (label === 'AVERAGE') return 'bg-label-warning';
                              if (label === 'BAD') return 'bg-label-danger';
                              if (label.includes('NOT OPTIMAL')) return 'bg-label-danger';
                              if (label === 'NO DATA') return 'bg-label-info';

                              return 'bg-label-secondary';
                            }

                            // ==============================
                            // FETCH BALANCE DATA
                            // ==============================
                            $.get("<?= base_url('admin/balance/history') ?>", function(res) {

                              if (!res || !res.status || !Array.isArray(res.data)) {
                                console.log('Balance data invalid');
                                return;
                              }

                              const earningCard = $('.card-title:contains("Productivity Ratio")')
                                                    .closest('.card');

                              const infoText = earningCard.find('small');
                              const badge    = earningCard.find('.badge');
                              let ytdBalance = 0;

                              const now = new Date();
                              const yearStart = new Date(now.getFullYear(), 0, 1);

                              // =========================
                              // INITIAL VALUE
                              // =========================
                              let balanceCredit = 0;
                              let balanceDebit  = 0;
                              let earnings = 0;
                              let expense  = 0;

                              let weeklyRevenue = [0,0,0,0,0,0,0];
                              let weeklyExpense = [0,0,0,0,0,0,0];
                              let todayRevenue = 0;
                              let todayExpense = 0;

                              // =========================
                              // MAIN LOOP
                              // =========================
                              res.data.forEach(row => {

                                const amount = parseFloat(row.amount) || 0;
                                if (!row.created_at) return;

                                const date = new Date(row.created_at);
                                if (isNaN(date)) return;

                                let day = date.getDay();
                                day = (day === 0) ? 6 : day - 1;

                                // =========================
                                // TODAY DATE
                                // =========================
                                const today = new Date();
                                const todayDateStr =
                                  today.getFullYear() + '-' +
                                  String(today.getMonth() + 1).padStart(2, '0') + '-' +
                                  String(today.getDate()).padStart(2, '0');

                                const rowDateStr =
                                  date.getFullYear() + '-' +
                                  String(date.getMonth() + 1).padStart(2, '0') + '-' +
                                  String(date.getDate()).padStart(2, '0');

                                // =========================
                                // BALANCE (lifetime)
                                // =========================
                                if (row.type === 'credit') balanceCredit += amount;
                                if (row.type === 'debit')  balanceDebit  += amount;

                                // =========================
                                // TOTAL (untuk earning/profit chart)
                                // =========================
                                if (row.category === 'revenue') {

                                  earnings += amount;
                                  weeklyRevenue[day] += amount;

                                  // =========================
                                  // END BALANCE (YTD)
                                  // =========================
                                  if (date >= yearStart && date <= now) {
                                    ytdBalance += amount;
                                  }
                                }

                                if (row.category === 'payroll' || row.category === 'extend') {
                                  expense += amount;
                                  weeklyExpense[day] += amount;
                                }

                                // =========================
                                // TODAY ONLY (angka besar atas)
                                // =========================
                                if (rowDateStr === todayDateStr) {

                                  if (row.category === 'revenue') {
                                    todayRevenue = amount; // bukan +=
                                  }

                                  if (row.category === 'payroll' || row.category === 'extend') {
                                    todayExpense += amount;
                                  }

                                }

                              });

                              // =========================
                              // REVENUE GROWTH
                              // =========================
                              let revenueByDate = {};

                              // group revenue per date
                              res.data.forEach(row => {

                                if (row.category === 'revenue' && row.created_at) {

                                  const date = new Date(row.created_at);

                                  const key =
                                    date.getFullYear() + '-' +
                                    String(date.getMonth() + 1).padStart(2, '0') + '-' +
                                    String(date.getDate()).padStart(2, '0');

                                  if (!revenueByDate[key]) revenueByDate[key] = 0;

                                  revenueByDate[key] += parseFloat(row.amount) || 0;
                                }
                              });

                              // ambil 2 hari terakhir
                              const sortedDates = Object.keys(revenueByDate).sort().reverse();

                              let growthPercent = 0;
                              let isGrowthUp = true;

                              if (sortedDates.length >= 2) {

                                const currentRevenue = revenueByDate[sortedDates[0]];
                                const lastRevenue    = revenueByDate[sortedDates[1]];

                                if (lastRevenue > 0) {
                                  growthPercent = ((currentRevenue - lastRevenue) / lastRevenue) * 100;
                                  isGrowthUp = growthPercent >= 0;
                                }
                              }

                              let secondaryPercent = 0;

                              if (sortedDates.length >= 3) {

                                const prevRevenue     = revenueByDate[sortedDates[1]];
                                const prevPrevRevenue = revenueByDate[sortedDates[2]];

                                if (prevPrevRevenue > 0) {
                                  secondaryPercent = ((prevRevenue - prevPrevRevenue) / prevPrevRevenue) * 100;
                                }
                              }

                              const secondaryRounded = Math.abs(secondaryPercent).toFixed(2);
                              const isSecondaryUp = secondaryPercent >= 0;


                              const growthRounded = Math.abs(growthPercent).toFixed(2);

                              // =========================
                              // UPDATE Monthly Growth CARD
                              // =========================

                              const totalCard = $('.card-title:contains("Monthly Growth")')
                                                  .closest('.card');

                              // ===== MAIN GROWTH (h1) =====
                              totalCard.find('.d-flex.align-items-center h1')
                                .text(growthRounded + '%');

                              // ===== ARROW ICON =====
                              const arrowIcon = totalCard.find('.d-flex.align-items-center i.ti');
                              const percentText = totalCard.find('.d-flex.align-items-center p');

                              // ===== MAIN ARROW =====
                              if (isGrowthUp) {
                                arrowIcon.removeClass('ti-chevron-down text-danger')
                                         .addClass('ti-chevron-up text-success');
                              } else {
                                arrowIcon.removeClass('ti-chevron-up text-success')
                                         .addClass('ti-chevron-down text-danger');
                              }

                              // ===== SECONDARY PERCENT (history sebelumnya) =====
                              percentText
                                .text(secondaryRounded + '%')
                                .removeClass('text-success text-danger')
                                .addClass(isSecondaryUp ? 'text-success' : 'text-danger');

                              // ===== Total DW Cost (Expense) =====
                              totalCard.find('h6:contains("Total DW Cost")')
                                .closest('.d-flex')
                                .find('p')
                                .text('-Rp ' + expense.toLocaleString('id-ID'))
                                .removeClass('text-success')
                                .addClass('text-danger');

                              // ===== Total Revenue (Earnings) =====
                              totalCard.find('h6:contains("Total Revenue")')
                                .closest('.d-flex')
                                .find('p')
                                .text('+Rp ' + earnings.toLocaleString('id-ID'))
                                .removeClass('text-danger')
                                .addClass('text-success');


                              // =========================
                              // LAST REVENUE DATE
                              // =========================
                              let lastRevenueDate = null;

                              res.data.forEach(row => {
                                if (row.category === 'revenue' && row.created_at) {
                                  const date = new Date(row.created_at);
                                  if (!isNaN(date)) {
                                    if (!lastRevenueDate || date > lastRevenueDate) {
                                      lastRevenueDate = date;
                                    }
                                  }
                                }
                              });

                              if (lastRevenueDate) {

                                const day   = lastRevenueDate.toLocaleDateString('id-ID', {
                                  day: '2-digit',
                                  month: 'short',
                                  year: 'numeric'
                                });

                                const time  = lastRevenueDate.toLocaleTimeString('id-ID', {
                                  hour: '2-digit',
                                  minute: '2-digit',
                                  hour12: false
                                });

                                infoText.text('Last today revenue update: ' + day + ' - ' + time + ' WIB');

                              } else {
                                infoText.text('No revenue recorded yet');
                              }

                              // =========================
                              // CALCULATION
                              // =========================
                              const balance = balanceCredit - balanceDebit;
                              const profit  = earnings - expense;
                              const totalFlow = earnings + expense;

                              const dwRatio = todayRevenue > 0
                                ? (todayExpense / todayRevenue) * 100
                                : 0;
                              const dwRounded = dwRatio.toFixed(2);

                              // =========================
                              // UPDATE CARD
                              // =========================
                              const todayNet = todayRevenue - todayExpense;

                              earningCard.find('h1').html(`
                                <span id="editableRevenue" style="cursor:pointer">
                                  Rp ${todayRevenue.toLocaleString('id-ID')}
                                </span>
                              `);

                              badge.text(dwRounded + '%');
                              badge.removeClass('bg-label-success bg-label-warning bg-label-danger bg-label-info');

                              let ratioLabel = '';
                              let ratioClass = '';

                              if (dwRatio >= 6 && dwRatio <= 10) {
                                ratioLabel = 'GOOD';
                                ratioClass = 'text-success';
                                badge.addClass('bg-label-success');
                              } 
                              else if (dwRatio > 10 && dwRatio <= 12) {
                                ratioLabel = 'AVERAGE';
                                ratioClass = 'text-warning';
                                badge.addClass('bg-label-warning');
                              } 
                              else if (dwRatio > 12 && dwRatio <= 15) {
                                ratioLabel = 'BAD';
                                ratioClass = 'text-danger';
                                badge.addClass('bg-label-danger');
                              } 
                              else if (dwRatio > 15) {
                                ratioLabel = 'NOT OPTIMAL MAN POWER';
                                ratioClass = 'text-danger';
                                badge.addClass('bg-label-danger');
                              } 
                              else {
                                ratioLabel = 'NO DATA';
                                ratioClass = 'text-info';
                                badge.addClass('bg-label-info');
                              }

                              earningCard.find('.earning-value')
                                .text('Rp ' + earnings.toLocaleString('id-ID'));

                              earningCard.find('.profit-value')
                                .text('Rp ' + profit.toLocaleString('id-ID'));

                              earningCard.find('.expense-value')
                                .text('Rp ' + expense.toLocaleString('id-ID'));

                              earningCard.find('.card-title small')
                                .removeClass('text-muted text-success text-warning text-danger text-info')
                                .addClass(ratioClass)
                                .text(ratioLabel);

                              // =========================
                              // PROGRESS BAR
                              // =========================
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
                                .css('width', earningPercent + '%');

                              earningCard.find('.profit-progress')
                                .css('width', profitPercent + '%');

                              earningCard.find('.expense-progress')
                                .css('width', expensePercent + '%');

                              // =========================
                              // WEEKLY CHART (SAFE)
                              // =========================
                              const weeklyEl = document.querySelector('#weeklyEarningReports');

                              if (weeklyEl) {

                                if (window.weeklyChartInstance) {
                                  window.weeklyChartInstance.destroy();
                                }

                                window.weeklyChartInstance = new ApexCharts(weeklyEl, {
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
                                  series: [{
                                    data: weeklyRevenue.map((val, i) => val - (weeklyExpense[i] || 0))
                                  }],
                                  xaxis: {
                                    categories: ['Mo','Tu','We','Th','Fr','Sa','Su'],
                                    labels: { style: { colors: labelColor } }
                                  },
                                  yaxis: { labels: { show: false } },
                                  dataLabels: { enabled: false }
                                });

                                window.weeklyChartInstance.render();
                              }

                              // =========================
                              // TOTAL STACKED CHART
                              // =========================
                              const totalChartEl = document.querySelector('#totalEarningChart');

                              if (totalChartEl) {

                                if (window.totalChartInstance) {
                                  window.totalChartInstance.destroy();
                                }

                                window.totalChartInstance = new ApexCharts(totalChartEl, {
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
                                });

                                window.totalChartInstance.render();
                              }

                              // =========================
                              // END BALANCE UPDATE (YTD)
                              // =========================
                              $('.end-balance-value')
                                .text('Rp ' + ytdBalance.toLocaleString('id-ID'));

                              // Optional: progress terhadap target tahunan (kalau ada)
                              const yearlyTarget = 5000000000; // ubah sesuai target
                              const endPercent = Math.min((ytdBalance / yearlyTarget) * 100, 100);

                              $('.end-balance-progress')
                                .css('width', endPercent + '%')
                                .attr('aria-valuenow', endPercent);
                            }, 'json');

                            // ==============================
                            // Last day attendances
                            // ==============================
                            $.get("<?= base_url('admin/balance/monthly-jobs') ?>", function(res){

                              if(!res.status) return;

                              const container = $('.card-title:contains("Last day attendances")')
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

                            $(document).on('click', '#editableRevenue', function(){

                                const current = $(this).text().replace(/[^0-9]/g,'');

                                const input = `
                                    <input type="number" 
                                           id="revenueInput" 
                                           class="form-control"
                                           value="${current}" />
                                    <button class="btn btn-sm btn-primary mt-2" id="saveRevenue">
                                        Save
                                    </button>
                                `;

                                $(this).parent().html(input);
                            });

                            $(document).on('click', '#saveRevenue', function(){

                                const amount = $('#revenueInput').val();

                                $.post("<?= base_url('admin/balance/update-revenue') ?>", {
                                    revenue: amount,
                                    date: selectedDate,
                                    '<?= csrf_token() ?>': '<?= csrf_hash() ?>'
                                }, function(res){

                                    if(!res.status){
                                        alert(res.message);
                                        return;
                                    }

                                    location.reload();

                                }, 'json');
                            });

                            $('#exportReportBtn').on('click', function(){

                                const url = "<?= base_url('admin/balance/export-report') ?>";

                                // langsung redirect supaya file ter-download
                                window.location.href = url;

                            });

                            let selectedDate = null;

                            function loadReport(type = 'all', date = null) {

                                if (!date) {
                                  if (!selectedDate) {
                                    selectedDate = new Date().toISOString().split('T')[0];
                                  }
                                } else {
                                  selectedDate = date;
                                }

                                let tableId, bodyId;

                                if (type === 'daily_worker') {
                                  tableId = '#dailyWorkerTable';
                                  bodyId  = '#dailyWorkerBody';
                                } else if (type === 'corporate') {
                                  tableId = '#companyTable';
                                  bodyId  = '#companyBody';
                                } else {
                                  tableId = '#allTable';
                                  bodyId  = '#allBody';
                                }

                                $.get("<?= base_url('admin/balance/daily-report') ?>", 
                                { 
                                  type: type,
                                  date: selectedDate
                                }, 
                                function(res){

                                  if(!res.status) return;

                                  const table = $(tableId);
                                  const tbody = $(bodyId);

                                  const todayLabelClass = getRatioBadgeClass(res.today_label);
                                  const mtdLabelClass   = getRatioBadgeClass(res.mtd_label);

                                  const formattedDate = new Date(res.date).toLocaleDateString('id-ID', {
                                    day: '2-digit',
                                    month: 'short',
                                    year: '2-digit'
                                  });

                                  // ==========================
                                  // Inject header with buttons
                                  // ==========================
                                  table.find('thead tr:first th:nth-child(2)').html(`
                                    <div class="d-flex justify-content-between align-items-center">
                                      <button class="btn btn-sm btn-outline-primary prev-day">◀</button>
                                      <span class="fw-bold">${formattedDate}</span>
                                      <button class="btn btn-sm btn-outline-primary next-day">▶</button>
                                    </div>
                                  `);

                                  tbody.html('');

                                  // ======================
                                  // Departments
                                  // ======================
                                  res.departments.forEach(dep => {

                                    tbody.append(`
                                      <tr class="department-row"
                                          data-department="${dep.department}"
                                          style="cursor:pointer">
                                        <td class="text-start fw-semibold text-primary">
                                          ${dep.department}
                                        </td>
                                        <td>${dep.dw > 0 ? dep.dw : ''}</td>
                                        <td>${dep.cost > 0 ? dep.cost.toLocaleString('id-ID') : ''}</td>
                                      </tr>
                                    `);

                                  });

                                  tbody.append(`<tr><td colspan="4"></td></tr>`);

                                  tbody.append(`
                                    <tr class="table-secondary fw-bold">
                                      <td class="text-start">Total Corporate Cost</td>
                                      <td></td>
                                      <td>${res.total_dw_cost.toLocaleString('id-ID')}</td>
                                    </tr>
                                  `);

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

                                }, 'json');
                            }
                           
                            // ==========================
                            // PREV DAY
                            // ==========================
                            $(document).on('click', '.prev-day', function(){

                              const date = new Date(selectedDate);
                              date.setDate(date.getDate() - 1);

                              selectedDate = date.toISOString().split('T')[0];

                              const activeType = getActiveType();
                              loadReport(activeType, selectedDate);

                            });

                            // ==========================
                            // NEXT DAY
                            // ==========================
                            $(document).on('click', '.next-day', function(){

                              const date = new Date(selectedDate);
                              date.setDate(date.getDate() + 1);

                              const today = new Date().toISOString().split('T')[0];

                              const newDate = date.toISOString().split('T')[0];

                              // cegah lebih dari hari ini
                              if (newDate > today) return;

                              selectedDate = newDate;

                              const activeType = getActiveType();
                              loadReport(activeType, selectedDate);

                            }); 

                            function getActiveType() {

                              if ($('#navs-pills-justified-home').hasClass('active')) {
                                return 'daily_worker';
                              } 
                              else if ($('#navs-pills-justified-profile').hasClass('active')) {
                                return 'corporate';
                              } 
                              else {
                                return 'all';
                              }

                            }

                            // ==========================
                            // CLICK DEPARTMENT → LOAD SKILL
                            // ==========================
                            $(document).on('click', '.department-row', function(){

                              const department = $(this).data('department');

                              let type;

                              if ($('#navs-pills-justified-home').hasClass('active')) {
                                type = 'daily_worker';
                              } 
                              else if ($('#navs-pills-justified-profile').hasClass('active')) {
                                type = 'corporate';
                              } 
                              else {
                                type = 'all';
                              }

                              $('.department-row').removeClass('table-active');
                              $(this).addClass('table-active');

                              loadSkillByDepartment(department, type);

                            });

                            // ==========================
                            // LOAD SKILL PER DEPARTMENT
                            // ==========================
                            function loadSkillByDepartment(department, type) {

                              // detect active tab
                              let containerId;

                              if ($('#navs-pills-justified-home').hasClass('active')) {
                                containerId = '#dailyWorkerskillRatioContainer';
                              } 
                              else if ($('#navs-pills-justified-profile').hasClass('active')) {
                                containerId = '#corporateskillRatioContainer';
                              } 
                              else {
                                containerId = '#allskillRatioContainer';
                              }

                               $.get("<?= base_url('admin/balance/skill-ratio-by-department') ?>",
                                {
                                  department: department,
                                  type: type,
                                  date: selectedDate   // ✅ tambah ini
                                },
                                function(res){
                                  if(!res.status) return;

                                  const container = $(containerId);
                                  container.html('');

                                  let html = `
                                    <div class="card shadow-sm">
                                      <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0">${department}</h6>
                                        <button 
                                          class="btn btn-sm btn-primary btn-department-detail"
                                          data-department="${department}"
                                          data-type="${type}">
                                          Detail
                                        </button>
                                      </div>
                                      <div class="card-body p-0">
                                        <table class="table table-sm table-bordered table-striped text-center mb-0">
                                          <thead class="table-light">
                                            <tr>
                                              <th class="text-start">Skill</th>
                                              <th>Cost</th>
                                              <th>Ratio (%)</th>
                                              <th>Status</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                  `;

                                  res.data.forEach(skill => {

                                    const badgeClass = getRatioBadgeClass(skill.label);

                                    html += `
                                      <tr>
                                        <td class="text-start">${skill.skill_name}</td>
                                        <td>${skill.cost.toLocaleString('id-ID')}</td>
                                        <td>${skill.ratio}%</td>
                                        <td>
                                          <span class="badge ${badgeClass}">
                                            ${skill.label}
                                          </span>
                                        </td>
                                      </tr>
                                    `;
                                  });

                                  html += `
                                          </tbody>
                                        </table>
                                      </div>
                                    </div>
                                  `;

                                  container.html(html);

                              }, 'json');
                            }

                            // ==========================
                            // INIT
                            // ==========================
                            loadReport('daily_worker', selectedDate);

                            $('[data-bs-target="#navs-pills-justified-home"]').on('click', function(){
                              loadReport('daily_worker', selectedDate);
                              $('#dailyWorkerskillRatioContainer').html('');
                            });

                            $('[data-bs-target="#navs-pills-justified-profile"]').on('click', function(){
                              loadReport('corporate', selectedDate);
                              $('#corporateskillRatioContainer').html('');
                            });

                            $('[data-bs-target="#navs-pills-justified-messages"]').on('click', function(){
                              loadReport('all', selectedDate);
                              $('#allskillRatioContainer').html('');
                            });

                            $(document).on('click', '.btn-department-detail', function(){

                              const department = $(this).data('department');
                              const type       = $(this).data('type');

                              const url = "<?= base_url('admin/balance/department-detail') ?>"
                                          + "?department=" + encodeURIComponent(department)
                                          + "&type=" + type
                                          + "&date=" + selectedDate;

                              window.open(url, '_blank');
                            });
                          })();
                        </script>

                        <?= $this->endSection() ?>
