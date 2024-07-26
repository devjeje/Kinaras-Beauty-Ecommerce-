<?php
  session_start();
  include ("koneksi.php");

  $query = "SELECT * FROM product LIMIT 20";
  $result = mysqli_query($conn, $query);
  // query product by category
  $skin = "SELECT * FROM product WHERE cat_id = 'CT002' ORDER BY price ASC LIMIT 10";
  $show = mysqli_query($conn, $skin);
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kinaras- eBeauty</title>

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
     
    <!--
    - MAIN
  -->

    <main>
      <!--
      - BANNER
    -->

      <div class="banner">
        <div class="container">
          <div class="slider-container has-scrollbar">
            <div class="slider-item">
              <img
                src="images/banner/bg1.png"
                alt="home banner"
                class="banner-img"
              />

              <div class="banner-content">
                <p class="banner-subtitle">Trending item</p>

                <h2 class="banner-title">The Originote</h2>

                <a href="#" class="banner-btn">Shop now</a>
              </div>
            </div>

            <div class="slider-item">
              <img
                src="images/banner/banner2.png"
                alt="modern sunglasses"
                class="banner-img"
              />

              <div class="banner-content">
                <p class="banner-subtitle">New Arrivals</p>

                <h2 class="banner-title">Modern sunglasses</h2>

                 <a href="#" class="banner-btn">Shop now</a>
              </div> 
            </div>

            <div class="slider-item">
              <img
                src="images/bg3.png"
                alt="new fashion summer sale"
                class="banner-img"
              />
              
              <div class="banner-content">
                <p class="banner-subtitle">Sale Offer</p>

                <h2 class="banner-title">New fashion summer sale</h2>

                <p class="banner-text">starting at &dollar; <b>29</b>.99</p>

                <a href="#" class="banner-btn">Shop now</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!--
      - CATEGORY
    -->

      <div class="category">
        <div class="container">
          <div class="category-item-container has-scrollbar">
            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/makeup.svg"
                  alt="makeup"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Make Up</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>

            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/skincare.svg"
                  alt="winter wear"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Skincare</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>

            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/haircare.svg"
                  alt="glasses & lens"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Hair Care</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>

            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/fragrance.svg"
                  alt="shorts & jeans"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Fragrance</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>

            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/nailcare.svg"
                  alt="t-shirts"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Nail Care</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>

            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/bathnbody.svg"
                  alt="jacket"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Bath & Body</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>

            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/oralcare.svg"
                  alt="watch"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Oral Care</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>

            <div class="category-item">
              <div class="category-img-box">
                <img
                  src="images/icons/giftset.svg"
                  alt="hat & caps"
                  width="30"
                />
              </div>

              <div class="category-content-box">
                <div class="category-content-flex">
                  <h3 class="category-item-title">Gift Set</h3>
                </div>
                <a href="#" class="category-btn">Show all</a>
              </div>
            </div>
          </div>
        </div>
      </div>

    <!-- Product -->
    <div class="product-container">
    <div class="container">
      <section id="off-banner" class="section-m1">
        <h2>Kinaras Exclusive</h2>
      </section>

        <section class="product-section" class="section-p1">
        <div class="pro-collection">
          <?php while ($row = mysqli_fetch_assoc($result)): ?>
          <div class="product">
            <a href="details.php?id=<?php echo $row['product_id'];?>" class="product-link" >
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
        <?php endwhile; ?>  
      </div>
      </section>

      <hr>
      <section id="off-banner"  class="section-m1">
        <h2>Bestie Deals For You</h2>
      </section>
        <section class="product-section" class="section-p1">
        <div class="pro-collection">
          <?php while ($row = mysqli_fetch_assoc($show)): ?>
          <div class="product">
            <a href="details.php?id=<?php echo $row['product_id'];?>" class="product-link" >
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
        <?php endwhile; ?>  
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
  </body>
</html>
