<!doctype html>
<html
  lang="en"
  class="light-style layout-wide customizer-hide"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="assets/"
  data-template="vertical-menu-template-no-customizer">
      <head>
          <meta charset="utf-8" />
          <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
          <title><?= $title ?></title>
          <meta name="description" content="" />

          <!-- Favicon -->
          <link rel="icon" type="image/x-icon" href="<?= base_url('assets/img/favicon/favicon.png') ?>" />

          <!-- Fonts -->
          <link rel="preconnect" href="https://fonts.googleapis.com" />
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
          <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
            rel="stylesheet" />

          <!-- Icons -->
          <link rel="stylesheet" href="<?= base_url('assets/vendor/fonts/fontawesome.css') ?>" />
          <link rel="stylesheet" href="<?= base_url('assets/vendor/fonts/tabler-icons.css') ?>" />
          <link rel="stylesheet" href="<?= base_url('assets/vendor/fonts/flag-icons.css') ?>" />

         <!-- Core CSS -->
          <link rel="stylesheet" href="<?= base_url('assets/vendor/css/rtl/core.css') ?>" />
          <link rel="stylesheet" href="<?= base_url('assets/vendor/css/rtl/theme-default.css') ?>" />
          <link rel="stylesheet" href="<?= base_url('assets/css/demo.css') ?>" />

          <!-- Vendors CSS -->
          <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/node-waves/node-waves.css') ?>" />
          <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css') ?>" />
          <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/typeahead-js/typeahead.css') ?>" />
          <!-- Vendor -->
          <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/@form-validation/form-validation.css') ?>" />
          <link rel="stylesheet" href="<?= base_url('assets/vendor/libs/sweetalert2/sweetalert2.css') ?>" />

          <!-- Page CSS -->
          <link rel="stylesheet" href="<?= base_url('assets/vendor/css/pages/page-auth.css') ?>" />

          <!-- Helpers -->
          <script src="<?= base_url('assets/vendor/js/helpers.js') ?>"></script>
          <script src="<?= base_url('assets/js/config.js') ?>"></script>
      </head>

      <body>
          <!-- Content -->
          <div class="container-xxl">
              <div class="authentication-wrapper authentication-basic container-p-y">
                  <div class="authentication-inner py-4">
                      <!-- Reset Password -->
                      <div class="card">
                          <div class="card-body">
                              <!-- Logo -->
                              <div class="app-brand justify-content-center mb-4 mt-2">
                                  <a href="#" class="app-brand-link">
                                      <img src="<?= base_url('assets/img/logo01.png') ?>" />
                                  </a>
                              </div>
                              <!-- /Logo -->
                              <h4 class="mb-1 pt-2">Reset Password</h4>
                              <p class="mb-4">
                                for <span class="fw-medium"><?= esc($email ?? '') ?></span>
                              </p>
                              <form id="formAuthentication" action="<?= base_url('update-password') ?>" method="post">
                                  <?= csrf_field() ?>
                                  <input type="hidden" name="token" value="<?= $token ?>">
                                  <div class="mb-3 form-password-toggle">
                                    <label class="form-label" for="password">New Password</label>
                                    <div class="input-group input-group-merge">
                                      <input
                                          type="password"
                                          id="password"
                                          class="form-control"
                                          name="password"
                                          required
                                          minlength="8"
                                          pattern="^(?=.*[!@#$%^&*(),.?&quot;:{}|<>]).{8,}$"
                                          title="Password must be at least 8 characters and contain a special character"
                                          placeholder="••••••••••"
                                      />
                                      <span class="input-group-text cursor-pointer"><i class="ti ti-eye-off"></i></span>
                                    </div>
                                  </div>
                                  <div class="mb-3 form-password-toggle">
                                      <label class="form-label" for="confirm-password">Confirm Password</label>
                                      <div class="input-group input-group-merge">
                                          <input
                                              type="password"
                                              id="confirm_password"
                                              class="form-control"
                                              name="confirm_password"
                                              required
                                              minlength="8"
                                              placeholder="••••••••••"
                                          />
                                          <span class="input-group-text cursor-pointer"><i class="ti ti-eye-off"></i></span>
                                      </div>
                                  </div>
                                  <button class="btn btn-primary d-grid w-100 mb-3">Set New Password</button>
                                  <div class="text-center">
                                    <a href="<?= base_url('login') ?>">
                                      <i class="ti ti-chevron-left scaleX-n1-rtl"></i>
                                      Back to login
                                    </a>
                                  </div>
                              </form>
                          </div>
                      </div>
                      <!-- /Reset Password -->
                  </div>
              </div>
          </div>

          <!-- Core JS -->
          <script src="<?= base_url('assets/vendor/libs/jquery/jquery.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/popper/popper.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/js/bootstrap.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/node-waves/node-waves.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/hammer/hammer.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/i18n/i18n.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/typeahead-js/typeahead.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/js/menu.js') ?>"></script>

          <!-- Vendors JS -->
          <script src="<?= base_url('assets/vendor/libs/@form-validation/popular.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/@form-validation/bootstrap5.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/@form-validation/auto-focus.js') ?>"></script>
          <script src="<?= base_url('assets/vendor/libs/sweetalert2/sweetalert2new.js') ?>"></script>

          <!-- Main JS -->
          <script src="<?= base_url('assets/js/mainresetpass.js') ?>"></script>

          <!-- Page JS -->
          <script src="<?= base_url('assets/js/pages-auth.js') ?>"></script>

          <script>
            $('#formAuthentication').on('submit', function(e){
                let password = $('#password').val();
                let confirm  = $('#confirm_password').val();

                let regex = /^(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/;

                if(!regex.test(password)){
                    e.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Invalid Password',
                        text: 'Password must be at least 8 characters and contain a special character'
                    });
                    return;
                }

                if(password !== confirm){
                    e.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Password Mismatch',
                        text: 'Confirm password does not match'
                    });
                    return;
                }
            });
          </script>

          <?php if (session()->getFlashdata('error')): ?>
              <script>
                  Swal.fire({
                      icon: 'error',
                      title: 'Failed',
                      text: '<?= session()->getFlashdata('error') ?>'
                  });
              </script>
          <?php endif; ?>

          <?php if (session()->getFlashdata('success')): ?>
              <script>
                  Swal.fire({
                      icon: 'success',
                      title: 'Success',
                      text: '<?= session()->getFlashdata('success') ?>'
                  });
              </script>
          <?php endif; ?>
      </body>
</html>
