<?php
include("koneksi.php");

if (isset($_GET['id'])) {
    $product_id = $_GET['id'];
    $stmt = $conn->prepare("SELECT * FROM product WHERE product_id = ?");
    $stmt->bind_param("s", $product_id); // 
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result && $result->num_rows > 0) {
        $product = $result->fetch_assoc();
    } else {
        echo "Produk tidak ditemukan.";
        exit;
    }
} else {
    echo "ID produk tidak diberikan.";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="css/style.css">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- icon -->
    <link
      rel="shortcut icon"
      href="images/icons/icon.ico"
      type="image/x-icon"
    />

     <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- remixicon -->
    <link
    href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"
    rel="stylesheet"/>

</head>
<body>
    <!-- Header -->
    <style>
    a{
      text-decoration: none;
    }
    dl, ol, ul {
    margin-top: 0;
    margin-bottom: 0;
    padding-left: 0;
    }
    p{
      margin-bottom: 0;
    }

    </style>
    <?php include("header.php");?> 

    <main>
     <div class="product-container">
    <div class="container">


<!-- content -->
<section class="py-5">
  <div class="container">
    <div class="row gx-4">
      <aside class="col-lg-6">
        <div class="border rounded-4 mb-3 d-flex justify-content-center">
          <a data-fslightbox="mygalley" class="rounded-4" target="_blank" data-type="image" href="dashboard/<?php echo htmlspecialchars($product['product_img']); ?>">
            <img style="max-width: 100%; max-height: 100vh; margin: auto;" class="rounded-4 fit" src="dashboard/<?php echo htmlspecialchars($product['product_img']); ?>"/>
          </a>
        </div>
        <!-- thumbs-wrap.// -->
        <!-- gallery-wrap .end// -->
      </aside>
      <main class="col-lg-6">
        <div class="ps-lg-3">
          <h3 class="title text-dark">
            <h3><?php echo htmlspecialchars($product['brand']); ?><br /></h3>
            <?php echo htmlspecialchars($product['product_name']); ?>
          </h3>
          <div class="d-flex flex-row my-3">
            <div class="text-warning mb-1 me-2">
               <p class="rating"><span>4.5</span> ★★★★★</p>
            </div>
            <span class="text-muted" id="order-count"><i class="fas fa-shopping-basket fa-sm mx-1"></i>Order</span>
            <span class="text-danger ms-2">In stock</span>
          </div>

          <div class="mb-1">
            <span class="h5">Rp. <?php echo number_format($product['price'], 0, ',', '.'); ?></span>
            <span class="text-muted">/pcs</span>
          </div>

          <p><?php echo htmlspecialchars($product['product_desc']); ?></p>
          <hr />

          <div class="row mb-1">
            <!-- col.// -->
             <div class="col-md-4 col-6 mb-2">
               <form action="add_cart.php" method="POST" class="add-to-cart-form">
                 <input type="hidden" name="product_id" value="<?php echo htmlspecialchars($product['product_id']); ?>">
                 <button type="submit" class="btn btn-primary shadow-0" style="background-color: #eb375e; border-color: #FA8072;">
                   <i class="me-1 fa fa-shopping-basket"></i> Add to bag
                 </button>
               </form>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>
</section>
<!-- content -->
    </div>
     </div>
    </main>

<!-- Footer -->
<style>
.footer-nav-item a{
   text-decoration: none;
}
</style>
<?php include "footer.php" ?>
       
    
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
  </body>
</html>