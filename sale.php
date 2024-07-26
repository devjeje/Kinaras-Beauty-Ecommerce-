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
 <!-- Filter -->
   

   
    <!-- MAIN  -->
    <main>
   <?php include("sidecategory.php");?>

     
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
        <select class="filter" id="price-range">
          <option value="low-high">Harga Terendah ke Tertinggi</option>
          <option value="high-low">Harga Tertinggi ke Terendah</option>
        </select>
      </div>
    </div>
    <br>
        <section class="product-section" class="section-p1">
        <div class="pro-collection">
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>
          <div class="product">
            <img src="images/products/n1.jpg" alt="Soft Pinch Liquid Blush">
            <h5>RARE BEAUTY</h5>
            <p>Soft Pinch Liquid Blush</p>
            <p class="price">Rp 437.000</p>
            <p class="rating">★★★★★</p>
            <button class="add-to-bag">TAMBAH KE TAS</button>
        </div>   
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
