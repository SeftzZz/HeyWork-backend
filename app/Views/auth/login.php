<!DOCTYPE html>
<html lang="en" class="Gibbu_@hotmail.com">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <title><?= $title ?></title>
        <link rel="shortcut icon" type="image/x-icon" href="<?= base_url('assets/img/favicon/favicon.png') ?>">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <link rel="stylesheet" href="<?= base_url('assets/login/style.css') ?>">
        <!-- SweetAlert2 -->
        <link rel="stylesheet" href="<?= base_url('assets/plugins/sweetalert2/sweetalert2.min.css') ?>">
        
        <script src="<?= base_url('assets/login/jquery-3.2.1.min.js') ?>"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.1/js/all.js"></script>
        <script src="<?= base_url('assets/login/jquery.transit.js') ?>"></script>
        <script>
            window.console = window.console || function(t) {};
        </script>
        <script>
            if (document.location.search.match(/type=embed/gi)) 
            {
              window.parent.postMessage("resize", "*");
            }
        </script>
    </head>

    <body translate="no" >
        <div id="container">
            <!-- <script>
                window.onload = function () {
                    Swal.fire({
                        title: "Presensi Online V2.2",
                        html: `
                        <table class='table' style='text-align:left;'>
                            <tr><td colspan='2'>Ada beberapa perubahan, yaitu:</td></tr>
                            <tr><td>1.</td><td>Form Pemantauan Kesehatan Mandiri ditiadakan</td></tr>
                            <tr><td valign='top'>2.</td><td>Timesheet diisi setelah mengklik tombol masuk</td></tr>
                            <tr><td valign='top'>3.</td><td>Timesheet diisi minimal 3 kegiatan</td></tr>
                            <tr><td valign='top'>4.</td><td>Jika timesheet kurang dari 3 kegiatan, tombol pulang tidak aktif</td></tr>
                        </table>
                        `,
                        icon: "info",
                        confirmButtonText: "Close"
                    });
                }
            </script> -->

            <div id="inviteContainer">
                <div class="logoContainer">
                    <img class="logo" src="<?= base_url('assets/login/attendance01.png') ?>"/>
                    <img class="text" src="<?= base_url('assets/login/logohw.png') ?>"/>
                </div>
                <div class="acceptContainer">
                    <?php if (session()->getFlashdata('error')): ?>
                        <div class="alert alert-danger">
                            <?= session()->getFlashdata('error') ?>
                        </div>
                    <?php endif; ?>
                    <form id="loginForm">
                        <?= csrf_field() ?>
                        <h1>Welcome to Hey! Work</h1>
                        <div class="formContainer">
                            <div class="formDiv" style="transition-delay: 0.2s">
                                <p>EMAIL</p>
                                <input type="text" required="" name="email" value="" id="email" autofocus="autofocus"/>
                            </div>
                            <div class="formDiv" style="transition-delay: 0.4s;margin-bottom:10px;">
                                <p>PASSWORD</p>
                                <input type="password" required="" name="password" value="" id="password"/>
                                <p>&nbsp;</p>
                                <p style="text-align:right;">
                                  <a href="<?= base_url('forgot-password') ?>" style="color: #ffffff;text-decoration: none;">Forgot Password</a>
                                </p>
                            </div>
                            <div class="formDiv" style="transition-delay: 0.6s">
                                <button type="submit" class="acceptBtn">Login</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <?php if (session()->getFlashdata('error')): ?>
                <script>
                    window.onload = function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Failed',
                            text: '<?= session()->getFlashdata('error') ?>',
                            confirmButtonText: "Close"
                        });
                    }
                </script>
            <?php endif; ?>
        </div>

        <script  src="<?= base_url('assets/login/js.js') ?>"></script>
        <!-- SweetAlert2 -->
        <script src="<?= base_url('assets/plugins/sweetalert2/sweetalert2.min.js') ?>"></script>
        <script>
            $('#loginForm').on('submit', async function(e) {
                e.preventDefault();

                const email = $('#email').val();
                const password = $('#password').val();

                try {

                    const res = await fetch('<?= base_url('api/auth/login') ?>', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            email: email,
                            password: password
                        })
                    });

                    const json = await res.json();

                    if (!res.ok) {
                        throw new Error(json.message || 'Login gagal');
                    }

                    // =========================
                    // 🔥 SAVE TOKEN
                    // =========================
                    localStorage.setItem('access_token', json.access_token);
                    localStorage.setItem('refresh_token', json.refresh_token);

                    // optional (biar gampang dipakai global)
                    window.jwtToken = json.access_token;

                    // =========================
                    // 🔥 REDIRECT
                    // =========================
                    window.location.href = "<?= base_url('admin/dashboard') ?>";

                } catch (err) {

                    Swal.fire({
                        icon: 'error',
                        title: 'Login Failed',
                        text: err.message
                    });

                }
            });
        </script>
    </body>
</html>