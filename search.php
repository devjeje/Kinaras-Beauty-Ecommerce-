<?php
include "koneksi.php";

if (isset($_GET['queryname'])) {
    $searchQuery = $_GET['queryname'];
    $searchSql = "SELECT * FROM product WHERE product_name LIKE ? OR brand LIKE ?"; 
    $stmt = $conn->prepare($searchSql);
    $searchTerm = "%" . $searchQuery . "%";
    $stmt->bind_param("ss", $searchTerm, $searchTerm); // Bind dua variabel

    // Debug: Print the query and search term
    error_log("SQL Query: " . $searchSql);
    error_log("Search Term: " . $searchTerm);

    $stmt->execute();
    $result = $stmt->get_result();

    $products = [];
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }

    // Debug: Print the number of products found
    error_log("Number of products found: " . count($products));

    // Simpan hasil pencarian ke session
    session_start();
    $_SESSION['search_results'] = $products;

    // Redirect ke halaman productsearch.php dengan parameter query string
    header("Location: productsearch.php?queryname=" . urlencode($searchQuery));
    exit();
}
?>