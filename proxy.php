<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$apiKey = '9dc76f0a31cef3aa4269a041ad3c518e'; // API KEY

if (isset($_GET['type'])) {
    if ($_GET['type'] == 'province') {
        $url = 'https://api.rajaongkir.com/starter/province';
    } elseif ($_GET['type'] == 'city' && isset($_GET['province'])) {
        $provinceId = $_GET['province'];
        $url = "https://api.rajaongkir.com/starter/city?province=$provinceId";
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_GET['type']) && $_GET['type'] == 'cost') {
    $url = 'https://api.rajaongkir.com/starter/cost';
    $postData = json_decode(file_get_contents('php://input'), true);

    if (isset($postData['origin']) && isset($postData['destination']) && isset($postData['weight']) && isset($postData['courier'])) {
        $postData = http_build_query([
            'origin' => $postData['origin'],
            'destination' => $postData['destination'],
            'weight' => $postData['weight'],
            'courier' => $postData['courier']
        ]);
    } else {
        echo json_encode(['error' => 'Invalid request']);
        exit;
    }
}

if ($url) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        "key: $apiKey",
        "Content-Type: application/x-www-form-urlencoded"
    ]);
    if (isset($postData)) {
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    }
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    error_log("Request URL: $url");
    if (isset($postData)) {
        error_log("Post Data: $postData");
    }
    
    if ($httpCode == 200) {
        // Log respons dari server
        error_log("Response: $response");
        echo $response;
    } else {
        // Log error
        error_log("Error fetching data from Rajaongkir: HTTP $httpCode - $response");
        echo json_encode(['error' => 'Failed to fetch data from API']);
    }
} else {
    echo json_encode(['error' => 'Invalid request']);
}
?>
