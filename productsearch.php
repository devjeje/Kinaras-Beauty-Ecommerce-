<?php
session_start();
include "koneksi.php";

// Cek apakah ada hasil pencarian di session
$searchResults = isset($_SESSION['search_results']) ? $_SESSION['search_results'] : [];

// Jika tidak ada hasil pencarian di session, lakukan pencarian ulang berdasarkan query string
if (empty($searchResults) && isset($_GET['queryname'])) {
    $searchQuery = $_GET['queryname'];
    $searchSql = "SELECT * FROM product WHERE (product_name LIKE ? OR brand LIKE ?)";

    $stmt = $conn->prepare($searchSql);
    $searchTerm = "%" . $searchQuery . "%";
    $stmt->bind_param("ss", $searchTerm, $searchTerm); // Bind dua variabel
    $stmt->execute();
    $result = $stmt->get_result();

    $searchResults = [];
    while ($row = $result->fetch_assoc()) {
        $searchResults[] = $row;
    }

    // Simpan hasil pencarian ke session
    $_SESSION['search_results'] = $searchResults;
}

// Debug: Print the number of search results
error_log("Number of search results: " . count($searchResults));
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sale</title>

    <!-- icon -->
    <link
      rel="shortcut icon"
      href="images/icons/icon.ico"
      type="image/x-icon"
    />

    <!-- css -->
    <link rel="stylesheet" href="css/style.css" />

    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- remixicon -->
    <link
    href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"
    rel="stylesheet"
/>
  </head>

  <body>
    <div class="overlay" data-overlay></div>

    <!-- modal -->

    <div class="modal" data-modal>
      <div class="modal-close-overlay" data-modal-overlay></div>
      </div>
    </div>

    <!-- header -->
     <?php include("header.php");?> 
     <br>
   
    <!-- MAIN  -->
    <main>
    <!-- Product -->
    <div class="product-container">
        
    <div class="container">
         <div id="filter">
      <div class="form-group">
        <select class="filter" id="category">
          <option value="">Filter by Category</option>
          <option value="makeup">Makeup</option>
          <option value="skincare">Skincare</option>
          <option value="haircare">Haircare</option>
          <option value="fragrance">Fragrance</option>
          <option value="nailcare">Nailcare</option>
          <option value="bath_body">Bath & Body</option>
          <option value="oralcare">Oralcare</option>
          <option value="giftset">Giftset</option>   
        </select>
      </div>
      <div class="form-group">
        <select class="filter" id="brand">
          <option value="">Filter by Brand</option>
          <option value="wardah">Wardah</option>
          <option value="makeover">Make Over</option>
          <option value="eminacosmetics">Emina Cosmetics</option>
          <option value="pixy">Pixy</option>
          <option value="Glad2Glow">Glad2Glow</option>
          <option value="maybelline">Maybelline</option>
          <option value="loreal">L'Oreal</option>
          <option value="skintific">Skintific</option>
          <option value="revlon">Revlon</option>
          <option value="thebodyshop">The Body Shop</option>
          <option value="nivea">Nivea</option>
          <option value="garnier">Garnier</option>
          <option value="viva">Viva</option>
          <option value="ellips">Ellips</option>
          <option value="safi">Safi</option>
          <option value="somethinc">Somethinc</option>
          <option value="avoskin">Avoskin</option>
          <option value="scarlett">Scarlett</option>
          <option value="msglow">MS Glow</option>
        </select>
      </div>
      <div class="form-group">
        <select class="filter" id="price-range" onchange="applyFilters()">
            <option value="">Pilih Rentang Harga</option>
            <option value="low-high">Harga Terendah ke Tertinggi</option>
            <option value="high-low">Harga Tertinggi ke Terendah</option>
        </select>
    </div>
    </div>
    <br>
       <section class="product-section" class="section-p1">
        <div class="pro-collection">
            <?php if (!empty($searchResults)): ?>
                <?php foreach ($searchResults as $row): ?>
                    <div class="product">
                        <a href="details.php?id=<?php echo $row['product_id'];?>" class="product-link">
                            <img src="dashboard/<?php echo $row['product_img']; ?>" alt="<?php echo $row['product_name']; ?>">
                            <h6><?php echo $row['brand']; ?></h6>
                            <p><?php echo $row['product_name']; ?></p>
                            <p class="price">Rp <?php echo number_format($row['price'], 0, ',', '.'); ?></p>
                            <p class="rating">★★★★★</p>
                        </a>
                        <form action="add_cart.php" method="POST" class="add-to-cart-form">
                            <button class="add-to-bag">Add to Bag
                                <input type="hidden" name="product_id" class="product-id" value="<?php echo htmlspecialchars($row['product_id']); ?>">
                                <input type="hidden" name="product_name" class="product-name" value="<?php echo htmlspecialchars($row['product_name']); ?>">
                                <input type="hidden" name="product_price" class="product-price" value="<?php echo htmlspecialchars($row['price']); ?>">
                                <input type="hidden" name="product_quantity" class="product-quantity" value="1">
                                <button type="submit" name="add_to_cart" class="add-to-bag" onclick="addToCart(this)">Add to Bag</button>
                            </button>
                        </form>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <p>Tidak ada produk.</p>
            <?php endif; ?>
        </div>
    </section>
      <br>

      </div>
    </div> 
    <br>
  
    <!-- Sidebar -->
     <?php include ("sidecategory.php"); ?>
    <!-- Sidebar -->

    </main>
      
    <!-- Footer -->
    <?php include ("footer.php"); ?>
    <!-- Javascript -->
    <script src="js/script.js"></script>
    <script src="js/function.js"></script>

    <!-- Ionicon Script -->
    <script
      type="module"
      src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"
    ></script>
    <script
      nomodule
      src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"
    ></script>

    <script>
    function applyFilters() {
        var priceRange = document.getElementById('price-range').value;
        var queryname = new URLSearchParams(window.location.search).get('queryname');
        var url = 'productsearch.php?queryname=' + encodeURIComponent(queryname) + '&price-range=' + encodeURIComponent(priceRange);
        window.location.href = url;
    }
    </script>
  </body>
</html>