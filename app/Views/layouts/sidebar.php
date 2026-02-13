                <?php $uri = service('uri')->getSegment(2); ?>
                <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
                    <div class="app-brand demo">
                        <a href="<?= base_url('admin/dashboard') ?>" class="app-brand-link">
                          <img src="<?= base_url('assets/img/logo01.png') ?>" />
                        </a>

                        <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto">
                          <i class="ti menu-toggle-icon d-none d-xl-block ti-sm align-middle"></i>
                          <i class="ti ti-x d-block d-xl-none ti-sm align-middle"></i>
                        </a>
                    </div>

                    <div class="menu-inner-shadow"></div>

                    <ul class="menu-inner py-1">
                        <li class="menu-item <?= ($uri=='dashboard')?'active':'' ?>">
                            <a href="<?= base_url('admin/dashboard') ?>" class="menu-link">
                                <i class="menu-icon tf-icons ti ti-smart-home"></i>
                                <div data-i18n="Dashboards">Dashboards</div>
                            </a>
                        </li>
                        <li class="menu-item <?= ($uri=='hotels')?'active':'' ?>">
                            <a href="<?= base_url('admin/hotels') ?>" class="menu-link">
                              <i class="menu-icon tf-icons ti ti-building"></i>
                              <div data-i18n="Hotels">Hotels</div>
                            </a>
                        </li>
                        <li class="menu-item <?= ($uri=='users')?'active':'' ?>">
                            <a href="<?= base_url('admin/users') ?>" class="menu-link">
                              <i class="menu-icon tf-icons ti ti-users"></i>
                              <div data-i18n="Users">Users</div>
                            </a>
                        </li>
                        <li class="menu-item <?= ($uri=='job-vacancies')?'active':'' ?>">
                            <a href="<?= base_url('admin/job-vacancies') ?>" class="menu-link">
                              <i class="menu-icon tf-icons ti ti-briefcase"></i>
                              <div data-i18n="Job Vacancies">Job Vacancies</div>
                            </a>
                        </li>
                        
                        <li class="menu-header small text-uppercase">
                          <span class="menu-header-text" data-i18n="Workers & Applications">Workers &amp; Applications</span>
                        </li>
                        <li class="menu-item <?= ($uri=='application')?'active':'' ?>">
                            <a href="<?= base_url('admin/application') ?>" class="menu-link">
                              <i class="menu-icon tf-icons ti ti-inbox"></i>
                              <div data-i18n="Applications">Applications</div>
                            </a>
                        </li>
                        <li class="menu-item <?= ($uri=='attendance')?'active':'' ?>">
                            <a href="<?= base_url('admin/attendance') ?>" class="menu-link">
                              <i class="menu-icon tf-icons ti ti-list"></i>
                              <div data-i18n="Attendances">Attendances</div>
                            </a>
                        </li>
                        
                        <li class="menu-header small text-uppercase">
                          <span class="menu-header-text">Finance</span>
                        </li>

                        <li class="menu-item <?= ($uri=='balance')?'active':'' ?>">
                            <a href="<?= base_url('admin/balance') ?>" class="menu-link">
                              <i class="menu-icon tf-icons ti ti-wallet"></i>
                              <div>Check Balance</div>
                            </a>
                        </li>

                        <li class="menu-item <?= ($uri=='balance-history')?'active':'' ?>">
                            <a href="<?= base_url('admin/balance/history') ?>" class="menu-link">
                              <i class="menu-icon tf-icons ti ti-history"></i>
                              <div>Transactions</div>
                            </a>
                        </li>

                        <li class="menu-item">
                            <a href="<?= base_url('logout') ?>" class="menu-link">
                                <i class="menu-icon tf-icons ti ti-logout"></i>
                                <div data-i18n="Logout">Logout</div>
                            </a>
                        </li>
                    </ul>
                </aside>
