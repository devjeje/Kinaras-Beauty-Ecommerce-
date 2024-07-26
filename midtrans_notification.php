<?php
session_start();
include "koneksi.php";
include "midtrans_config.php";

// Mengecek koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Mengambil data dari notifikasi Midtrans
$input = file_get_contents('php://input');

// Log input mentah untuk debug
file_put_contents("logs/raw_input_log.txt", $input . PHP_EOL, FILE_APPEND);

$json = json_decode($input, true);

// Log hasil decode JSON untuk debug
file_put_contents("logs/decoded_json_log.txt", print_r($json, true) . PHP_EOL, FILE_APPEND);

// Pastikan data JSON diterima dengan benar
if ($json === null) {
    http_response_code(400);
    echo json_encode(["status" => "invalid JSON"]);
    exit();
}

// Mengecek status pembayaran
$transaction_status = isset($json['transaction_status']) ? $json['transaction_status'] : null;
$order_id = isset($json['order_id']) ? $json['order_id'] : null;
$signature_key = isset($json['signature_key']) ? $json['signature_key'] : null;
$status_code = isset($json['status_code']) ? $json['status_code'] : null;
$gross_amount = isset($json['gross_amount']) ? $json['gross_amount'] : null;

// Verifikasi signature key
$calculated_signature_key = hash('sha512', $order_id . $status_code . $gross_amount . $server_key);
if ($signature_key !== $calculated_signature_key) {
    http_response_code(400);
    echo json_encode(["status" => "invalid signature"]);
    exit();
}

// Proses berdasarkan status transaksi
if ($transaction_status == 'settlement') {
    // Pastikan user_id ada di sesi
    if (isset($_SESSION['user_id']) && !empty($_SESSION['user_id'])) {
        // Menghapus produk di keranjang berdasarkan sesi user id
        clear_user_cart($_SESSION['user_id'], $conn);
        
        // Mengirim respon ke Midtrans
        http_response_code(200);
        echo json_encode(["status" => "success"]);
    } else {
        http_response_code(400);
        echo json_encode(["status" => "user_id not found in session"]);
    }
} else {
    http_response_code(400);
    echo json_encode(["status" => "failed"]);
}

// Fungsi untuk menghapus produk di keranjang berdasarkan user_id
function clear_user_cart($user_id, $conn) {
    // Logika untuk menghapus produk di keranjang
    // Contoh: query ke database dan hapus produk berdasarkan user_id
    $sql = "DELETE FROM bag WHERE user_id = '$user_id'";
    if ($conn->query($sql) === TRUE) {
        echo "Record deleted successfully";
    } else {
        echo "Error deleting record: " . $conn->error;
    }
}

// Menutup koneksi
$conn->close();
?>