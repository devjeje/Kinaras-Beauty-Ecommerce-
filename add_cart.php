<?php
session_start();
include "koneksi.php"; // Pastikan koneksi ke database di-include

// Cek apakah user sudah login
if (!isset($_SESSION['user_id'])) {
    echo '<script>alert("Silahkan login untuk menambahkan produk!"); window.location.href = "index.php";</script>';
    exit;
}

$user_id = $_SESSION['user_id'];
$product_id = mysqli_real_escape_string($conn, $_POST["product_id"]);

// Validasi input
if (empty($user_id) || empty($product_id)) {
    echo '<script>alert("User ID atau Product ID tidak boleh kosong") window.location.href = "index.php";;</script>';
    exit;
}

// Gunakan prepared statements untuk mencegah SQL injection
$stmt = $conn->prepare("INSERT INTO bag(user_id, product_id) VALUES (?, ?)");
$stmt->bind_param("ss", $user_id, $product_id);

if ($stmt->execute()) {
    echo '<script>alert("Produk telah ditambahkan ke cart"); window.location.href = "index.php";</script>';
    exit;       
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>