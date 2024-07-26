<?php
session_start();

// Pastikan session user_id tersedia
if (!isset($_SESSION['user_id'])) {
    echo "User not logged in.";
    exit;
}

$id = $_SESSION['user_id'];


// Query untuk memanggil fungsi countCart
// Count cart sudah di define di database
$sql = "SELECT count_cart('$id') AS bag_count";
$stmt = $conn->prepare($sql);
$result = $conn->query($sql);

if ($row = $result->fetch_assoc()) {
    $jmlh = $row['bag_count'];
} else {
    echo "No bags found.";
}

// Tutup koneksi
$conn->close();
?>
