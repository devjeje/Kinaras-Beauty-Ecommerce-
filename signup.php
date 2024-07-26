 <?php
  include "koneksi.php"; //Menghubungkan ke database

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Memeriksa Checkbox sebelum meyimpan inputan user ke dalam database
  if (!isset($_POST['agree-statement'])) {
      echo '<script>
          alert("Anda harus menyetujui Privacy Policy dan Terms & Conditions sebelum mendaftar.");
          window.history.back();
          </script>';
      exit();
  }
    // Mengamankan inputan user dari serangan SQL Injection
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $phone = mysqli_real_escape_string($conn, $_POST['nohp']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);
    $repassword = mysqli_real_escape_string($conn, $_POST['repassword']);

    // Validasi password dan konfirmasi password
    if ($password != $repassword) {
        echo '<script>
                alert("Password dan Konfirmasi Password tidak cocok. Silakan isi ulang.");
                window.history.back();
              </script>';
        exit();
    }

    // Memasukkan inputan user ke dalam database
    $sql = "INSERT INTO user (user_fullname, user_nickname, user_pass, user_nohp, user_email) 
            VALUES ('$name', '$username', '$password', '$phone', '$email')";

    // Jika berhasil tersimpan maka notif akan ditampilkan
    if (mysqli_query($conn, $sql)) {
        echo '<script>
                alert("Pendaftaran berhasil. Silakan login.");
                window.location.href = "login.php";
              </script>';
    // Jika Gagal tersimpan maka notif akan ditampilkan
    } else {
        echo '<script>
                // alert("Terjadi kesalahan. Silakan coba lagi."); 
                window.history.back();
              </script>'; 
    }

    // menutup koneksi
    mysqli_close($conn);
}
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kinaras Buyer Sign Up Page</title>
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
    <div class="form-register">
      <h2>Register</h2>
      <form action="#" method="POST">
        <div class="form-controlreg">
          <input type="text" name="name" required />
          <label>Name</label>
        </div>
        <div class="form-controlreg">
          <input type="text" name="username" required />
          <label>Username</label>
        </div>
        <div class="form-controlreg">
          <input type="email" name="email" required />
          <label>Email address</label>
        </div>
        <div class="form-controlreg">
          <input type="text" name="nohp" required />
          <label>Phone number</label>
        </div>
        <div class="form-controlreg">
          <input type="password" name="password" required />
          <label> Password</label>
        </div>
        <div class="form-controlreg">
          <input type="password" name="repassword" required />
          <label> Re Password</label>
        </div>
        <button type="submit">Register</button>
        <div class="agree-statement">
        <input type="checkbox" id="agree-statement" name="agree-statement" /> By registering you have agreed to the
        <a href="privacypolicy.php">Privacy Policy</a> and <a href="terms.php">Terms & Conditions</a>
      </div>
      </form>
      <a href="#">Need help?</a>
      <p>Have account? <a href="login.php">Sign in</a></p>
    </div>
  </body>
</html>
