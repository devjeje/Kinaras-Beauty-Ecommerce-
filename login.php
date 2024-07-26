<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kinaras Buyer Login Page</title>
    <link rel="stylesheet" href="css/auth.css" />

    <!-- icon -->
    <link
      rel="shortcut icon"
      href="images/icons/icon.ico"
      type="image/x-icon"
    />


    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <nav>
      <a href="index.php"
        ><img src="images/icons/logo.svg" alt="logo"
      /></a>
    </nav>
    <div class="form-wrapper">
      <h2>Sign In</h2>
      <form action="login.php" method="POST">
        <div class="form-control">
          <input type="text" name="username" required />
          <label>Email or phone number</label>
        </div>
        <div class="form-control">
          <input type="password" name="password" required />
          <label>Password</label>
        </div>
        <button type="submit">Sign In</button>
        <div class="form-help">
          <div class="remember-me">
            <input type="checkbox" id="remember-me" />
            <label for="remember-me">Remember me</label>
          </div>
          <a href="#">Need help?</a>
        </div>
      </form>
      <p>New to Kinaras? <a href="signup.php">Register now</a></p>
    </div>
  </body>
  <?php
    session_start(); // Memulai sesi untuk menyimpan data pengguna
    include 'koneksi.php'; // Menghubungkan ke database

    if ($_SERVER['REQUEST_METHOD'] == 'POST') { // Memeriksa apakah form telah disubmit
        $username = $_POST['username']; // Mengambil username dari input
        $password = $_POST['password']; // Mengambil password dari input 

        $username = mysqli_real_escape_string($conn, $username); // Menghindari SQL Injection
        $password = mysqli_real_escape_string($conn, $password); // Menghindari SQL Injection

        // Memeriksa inputan user dengan database
        $sql = "SELECT * FROM user WHERE (user_email='$username' OR user_nohp='$username' OR user_nickname='$username') AND user_pass='$password'";
        $result = mysqli_query($conn, $sql); // Menjalankan query

        if (mysqli_num_rows($result) == 1) { // Jika ada satu hasil
            $row = mysqli_fetch_assoc($result); // Mengambil data pengguna
            $_SESSION['username'] = $username; // Menyimpan username ke sesi
            $_SESSION['password'] = $password; // Menyimpan password ke sesi
            $_SESSION['user_img'] = $row['user_img']; // Menyimpan gambar pengguna ke sesi
            $_SESSION['user_nickname'] = $row['user_nickname']; // Menyimpan nickname pengguna ke sesi
            $_SESSION['user_fullname'] = $row['user_fullname']; // Menyimpan nama lengkap pengguna ke sesi
            $_SESSION['user_email'] = $row['user_email']; // Menyimpan email pengguna ke sesi
            $_SESSION['admin_nickname'] = $row['admin_nickname']; // Menyimpan nickname admin ke sesi
            $_SESSION['user_id'] = $row['user_id']; // Menyimpan ID pengguna ke sesi
        } else {
            // Menyimpan pesan kesalahan ke dalam session
            $_SESSION['error'] = "Username atau Password salah"; // Pesan kesalahan
            // Mengarahkan kembali ke halaman login
            header("Location: login.php"); // Redirect ke halaman login
            exit(); // Menghentikan eksekusi script
        }
    }
    if (isset($_SESSION['username'])) { ?> // Jika pengguna sudah login
        <script>
            // alert('Login Success'); // Menampilkan alert (dihapus dari komentar)
            setTimeout(function() { // Menunggu 900ms sebelum redirect
                window.location.href = 'index.php'; // Redirect ke halaman utama
            }, 900);
        </script>
    <?php
    } ?> 
<?php if (isset($_SESSION['error'])): ?> // Jika ada pesan kesalahan
    <script>alert('<?= $_SESSION['error']; ?>');</script> // Menampilkan pesan kesalahan
    <?php 
    unset($_SESSION['error']); // Menghapus pesan kesalahan dari sesi
    endif; 
?>
</html>