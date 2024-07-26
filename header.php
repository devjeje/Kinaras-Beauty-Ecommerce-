 <?php
 include "koneksi.php";
 // Pastikan session user_id tersedia
if (!isset($_SESSION['user_id'])) {
    // echo "User not logged in.";
   $bag_count = 0;
 } else {
   $id = $_SESSION['user_id'];

   // Query untuk memanggil fungsi countCart
   $sql = "SELECT count_cart('$id') AS bag_count";
   $stmt = $conn->prepare($sql);
   $hasil = $conn->query($sql);

   $bag_count = 0;
   if ($row = $hasil->fetch_assoc()) {
     $bag_count = $row['bag_count'];
   } else {
     $bag_count = 0;
   }
 }
 ?>
 
 <!-- header -->
    <header>
      <div class="header-top">
        <div class="container">
          <ul class="header-social-container">
            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-facebook"></ion-icon>
              </a>
            </li>

            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-twitter"></ion-icon>
              </a>
            </li>

            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-instagram"></ion-icon>
              </a>
            </li>

            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-linkedin"></ion-icon>
              </a>
            </li>
          </ul>

          <div class="header-alert-news">
            <p>
              <b>Kinaras</b>
              Beauty Ecommerce
            </p>
          </div>

          <div class="header-top-actions">
            <select name="language">
              <option value="en-ID">Indonesia</option>
              <option value="es-US">English</option>
            </select>
          </div>
        </div>
      </div>

      <div class="header-main">
        <div class="container">
          <a href="index.php" class="header-logo">
            <img
              src="images/icons/logo.svg"
              alt="logo"
              width="200"
              height="46"
            />
          </a>

          <div class="header-search-container">
            <form action="search.php" method="GET">
            <input
              type="search"
              name="queryname"
              class="search-field"
              placeholder="What are you looking for?"
            />
            <button type="submit" class="search-btn">
              <ion-icon name="search-outline"></ion-icon>
            </button>
            </form>
          </div>

          <div class="header-user-actions"> 
          <?php if(isset($_SESSION['username'])): ?>
            <div class="action">
              <div class="profile" onclick="profileToggle();">
                <img src="dashboard/<?php echo $_SESSION['user_img']; ?>" />
              </div>
              <div class="menu">
                <h3><?php echo $_SESSION['user_fullname']; ?></h3>
                <p><?php echo $_SESSION['user_email']; ?></p>
                <ul>
                  <li>
                    <a href="#">My Profile</a>
                  </li>
                  <li>
                    <a href="#">My Order</a>
                  </li>
                  <li>
                    <a href="#">Review</a>
                  </li>
                  <li>
                    <a href="logout.php">Logout</a>
                  </li>
                </ul>
              </div>
            </div>
          <?php else: ?>
            <div class="login-btn">
              <a href="login.php">
                <button class="menu-title">Login</button>
              </a>
            </div>
          <?php endif; ?>
          
          <a href="cartlist.php">
         <button class="action-btn">
            <ion-icon name="bag-handle-outline"></ion-icon>
            <span id="cart-count" class="count"><?= $bag_count?></span>
         </button>
         </a>
        </div>    
      </div>
    </div>  
  </div>

      <nav class="desktop-navigation-menu">
        <div class="container">
          <ul class="desktop-menu-category-list">
            <li class="menu-category">
              <a href="index.php" class="menu-title">Home</a>
            </li>

            <li class="menu-category">
              <a href="#" class="menu-title">Categories</a>

              <div class="dropdown-panel">

                <!-- CATEGORIES MAKEUP -->
                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">MAKE UP</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Face</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Eyes</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Lips</a>
                  </li> 
                </ul>

                <!-- CATEGORIES SKINCARE -->
                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">SKINCARE</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Eye Care</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Lip Care</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Moisturizer</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Cleanser</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Face Mask</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Sun Care</a>
                  </li>
                </ul>


                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">HAIR CARE</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Shampoo</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Hair Tools</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Hair Treatment</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Hair Styling</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Hair Care Set</a>
                  </li>
                </ul>

                <!-- CATEGORIES FRAGRANCE  -->
                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">FRAGRANCE</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Body Fragrance</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Home Fragrance</a>
                  </li>
                </ul>

                <!-- CATEGORIES NAIL CARE -->
                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">NAIL CARE</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">MANICURE & PEDICURE</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">NAIL BEAUTY</a>
                  </li>
                </ul>
                
                <!-- CATEGORIES BATH & BODY -->
                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">BATH & BODY</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Body Treatment</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Body Cleanser</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Body Care</a>
                  </li>
                </ul>

                <!-- CATEGORIES ORAL CARE -->
                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">ORAL CARE</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Toothpaste</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Mouthwash</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Tooth Whitening</a>
                  </li>
                </ul>

                <!-- CATEGORIES GIFT SET -->
                <ul class="dropdown-panel-list">
                  <li class="menu-title">
                    <a href="#">GIFT SET</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Gift Set For Her</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Kinaras Bundle</a>
                  </li>

                  <li class="panel-list-item">
                    <a href="#">Value Pack</a>
                  </li>
                </ul>
              </div>
            </li>

            <li class="menu-category">
              <a href="promo.php" class="menu-title">Promo</a>
            </li>

            <li class="menu-category">
              <a href="#" class="menu-title">Sale</a>
            </li>

            <li class="menu-category">
              <a href="ourstore.php" class="menu-title">Our Store</a>
            </li>

            <li class="menu-category">
              <a href="blog.php" class="menu-title">Blog</a>
            </li>
          </ul>
        </div>
      </nav>

      <div class="mobile-bottom-navigation">
        <button class="action-btn" data-mobile-menu-open-btn>
          <ion-icon name="menu-outline"></ion-icon>
        </button>

        <a href="cartlist.php">
        <button class="action-btn">
          <ion-icon name="bag-handle-outline"></ion-icon>
          <span id="cart-count-mobile" class="count"><?= $bag_count?></span>
        </button>
        </a>

        <a href="index.php">
        <button class="action-btn">
          <ion-icon name="home-outline"></ion-icon>
        </button>
        </a>

        <button class="action-btn" data-mobile-menu-open-btn>
          <ion-icon name="grid-outline"></ion-icon>
        </button>
        
      <div class="mobileaction">
        <?php if(isset($_SESSION['username'])): ?>
          <div class="profile" onclick="mobileprofileToggle();">
            <img src="dashboard/<?php echo $_SESSION['user_img']; ?>" />
          </div>
          <div class="profile-menu-mobile">
            <h3><?php echo $_SESSION['user_fullname'];?></h3>
            <p><?php echo $_SESSION['user_email']; ?></p>
            <ul>
              <li>
                <a href="#">My Profile</a>
              </li>
              <li>
                <a href="#">My Order</a>
              </li>
              <li>
                <a href="#">Review</a>
              </li>
              <li>
                <a href="logout.php">Logout</a>
              </li>
            </ul>
          </div>
        <?php else: ?>
          <a href="login.php">
            <button class="action-btn">
              <i class="ri-user-line"></i>
            </button>
          </a>
        <?php endif; ?>
      </div>
    </div>

      <nav class="mobile-navigation-menu has-scrollbar" data-mobile-menu>
        <div class="menu-top">
          <h2 class="menu-title">Menu</h2>

          <button class="menu-close-btn" data-mobile-menu-close-btn>
            <ion-icon name="close-outline"></ion-icon>
          </button>
        </div>

        <ul class="mobile-menu-category-list">
          <li class="menu-category">
            <a href="index.php" class="menu-title">Home</a>
          </li>

           <li class="menu-category">
            <a href="promo.php" class="menu-title">Promo</a>
          </li>

          <li class="menu-category">
            <a href="sale.php" class="menu-title">Sale</a>
          </li>

          <li class="menu-category">
            <a href="ourstore.php" class="menu-title">Our Store</a>
          </li>

          <li class="menu-category">
            <a href="blog.php" class="menu-title">Blog</a>
          </li>
        </ul>

        <div class="menu-bottom">
          <ul class="menu-category-list">
            <li class="menu-category">
              <button class="accordion-menu" data-accordion-btn>
                <p class="menu-title">Language</p>

                <ion-icon
                  name="caret-back-outline"
                  class="caret-back"
                ></ion-icon>
              </button>

              <ul class="submenu-category-list" data-accordion>
                <li class="submenu-category">
                  <a href="#" class="submenu-title">Indonesia</a>
                </li>
                <li class="submenu-category">
                  <a href="#" class="submenu-title">English</a>
                </li> 
              </ul>
            </li>
          </ul>

          <ul class="menu-social-container">
            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-facebook"></ion-icon>
              </a>
            </li>

            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-twitter"></ion-icon>
              </a>
            </li>

            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-instagram"></ion-icon>
              </a>
            </li>

            <li>
              <a href="#" class="social-link">
                <ion-icon name="logo-linkedin"></ion-icon>
              </a>
            </li>
          </ul>
        </div>

      </nav>
    </header>
