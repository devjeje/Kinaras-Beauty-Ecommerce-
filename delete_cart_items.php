   <?php
   session_start();

   // Pastikan user sudah login
   if (!isset($_SESSION['user_id'])) {
       echo json_encode(['status' => 'error', 'message' => 'User not logged in']);
       exit;
   }

   // Hapus semua item dari keranjang
   // Misalnya, jika Anda menyimpan keranjang di sesi
   unset($_SESSION['cart_items']);

   echo json_encode(['status' => 'success', 'message' => 'Cart items deleted']);
   ?>