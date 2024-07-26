<?php
session_start();
require_once 'midtrans_config.php';


$gross_amount = intval($_POST['gross_amount']);
$name = $_POST['name'];
$nohp = $_POST['nohp'];
$buyer_address = $_POST['address'];
$email = $_SESSION['user_email']; 

$cartlist = $_SESSION['cartlist']; // Asumsi cartlist disimpan di session
$product_details = array();

foreach ($cartlist as $item) {
    $product_details[] = array(
        'id' => $item['product_id'],
        'price' => $item['price'],
        'quantity' => 1,
        'name' => $item['product_name'],
    );
}

// Menambahkan ongkir sebagai produk
$product_details[] = array(
    'id' => 'SHIP' . rand(),
    'price' => intval($_POST['shipping-cost']),
    'quantity' => 1,
    'name' => 'Biaya Pengiriman',
    );
$params = array(
    'transaction_details' => array(
        'order_id' => rand(),
        'gross_amount' => $gross_amount,
    ),
    'customer_details' => array(
        'first_name' => $name,
        'phone' => $nohp,
        'email' => $email,
        'billing_address' => array(
            'address' => $buyer_address,  
        ),
        'shipping_address' => array(
            'first_name' => $name,
            'phone' => $nohp,
            'email' => $email,
            'address' => $buyer_address,
        ),
    ),
    'item_details' => $product_details,
);

$snapToken = \Midtrans\Snap::getSnapToken($params);
echo json_encode(array('token' => $snapToken));
?>