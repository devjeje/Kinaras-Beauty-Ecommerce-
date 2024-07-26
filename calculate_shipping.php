<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $cityId = $data['cityId'];
    $courier = $data['courier'];
    $apiKey = '9dc76f0a31cef3aa4269a041ad3c518e'; // API KEY

    $postData = [
        'key' => $apiKey,
        'origin' => '419', //kode wilayah yogyakarta
        'destination' => $cityId,
        'weight' => 1000,  //Define Berat produk
        'courier' => $courier //kurir ekspedisi pilihan pembeli akan masuk ke variabel courier
    ];

    $ch = curl_init('https://api.rajaongkir.com/starter/cost');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postData));
    $response = curl_exec($ch);
    curl_close($ch);

    $responseData = json_decode($response, true);

    if (isset($responseData['rajaongkir']['results'][0]['costs'][0]['cost'][0]['value'])) {
        $shippingCost = $responseData['rajaongkir']['results'][0]['costs'][0]['cost'][0]['value'];
        echo json_encode(['success' => true, 'shippingCost' => $shippingCost]);
    } else {
        echo json_encode(['success' => false]);
    }
} else {
    echo json_encode(['success' => false]);
}
?>

<!-- setelah semua data terpenuhi maka akan merequest total ongkir ke API rajaongkir -->