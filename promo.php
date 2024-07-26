<?php
session_start();
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Promo</title>

    <!-- icon -->
    <link
      rel="shortcut icon"
      href="images/icons/icon.ico"
      type="image/x-icon"
    />

    <!-- css -->
    <link rel="stylesheet" href="css/promo.css" />
    <link rel="stylesheet" href="css/style.css">

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

    <!-- Container -->
    <div class="product-container">
      <div class="container">

    <!-- Promo-card -->
    <div class="promo-card">
      <h2 class="promo-title">KINARAS VOUCHERS</h2>
      <div class="promo-cards-container">
        <div class="promo-card-item" onclick="openPopup('popup1')">
          <img src="images/vouchers/vouchers1.png" alt="Voucher Bebas Ongkir" class="promo-card-img">
          <p class="promo-card-text">BEBAS ONGKIR HINGGA 30K</p>
          <p class="promo-card-subtext">Min. belanja Rp 199.000</p>
        </div>
        <div class="promo-card-item" onclick="openPopup('popup2')">
          <img src="images/vouchers/vouchers2.png" alt="Voucher 10%" class="promo-card-img">
          <p class="promo-card-text">VOUCHER 10%</p>
          <p class="promo-card-subtext">Up to 100K</p>
          <p class="promo-card-subtext">Min. belanja Rp 400.000</p>
        </div>
        <div class="promo-card-item" onclick="openPopup('popup3')">
          <img src="images/vouchers/vouchers3.png" alt="Voucher 5%" class="promo-card-img">
          <p class="promo-card-text">VOUCHER 5%</p>
          <p class="promo-card-subtext">Up to 30K</p>
          <p class="promo-card-subtext">Min. belanja Rp 280.000</p>
        </div>
      </div><br>

    <div class="featured-promotions">
      <h2 class="promo-title">FEATURED PROMOTIONS</h2>
      <div class="promo-grid">
        <div class="promo-item">
          <img src="images/vouchers/discbni.png" alt="Promo 3">
          <div class="promo-details">
            <h3>Promo 1</h3>
            <p>Get up to 30% off with BNI bank payment</p>
            <p>Valid until 8 July 2024</p>
            <button>Lihat Promo</button>
          </div>
        </div>
        <div class="promo-item">
          <img src="images/vouchers/disccimbniaga.png" alt="Promo 2">
          <div class="promo-details">
            <h3>Promo 2</h3>
            <p>Get up to 50% off with CIMB NIAGA bank payment</p>
            <p>Valid until 8 July 2024</p>
            <button>Lihat Promo</button>
          </div>
        </div>
        <div class="promo-item">
          <img src="images/vouchers/discbri.png" alt="Promo 1">
          <div class="promo-details">
            <h3>Promo 3</h3>
            <p>Get up to 60% off with BRI bank payment</p>
            <p>Valid until 8 July 2024</p>
            <button>Lihat Promo</button>
          </div>
        </div>
      </div>
    </div>
    </div>
    <br>

    <!-- Popup Modals -->
    <div id="popup1" class="popup">
    <div class="popup-content">
    <span class="close" onclick="closePopup('popup1')">&times;</span>
    <h2>FREE SHIPPING REGULAR</h2>
    <div class="popup-description">
      <h3>DESKRIPSI</h3>
      <p>Free shipping untuk pembelian dengan minimal belanja Rp 199.000!</p>
      <div class="popup-details">
        <div class="detail-item">
          <span>Minimum Transaksi</span>
          <span>Rp199.000</span>
        </div>
        <div class="detail-item">
          <span>Periode Promo</span>
          <span>10-16 Juli 2024</span>
        </div>
        <div class="detail-item">
          <span>Kode Promo</span>
          <span>FREESHIP</span>
          <button class="copy-code" onclick="copyCode('FREESHIP')">SALIN KODE</button>
        </div>
      </div>
    </div>
    <div class="popup-terms">
      <h3>SYARAT & KETENTUAN</h3>
      <ul>
        <li>&#x2022; &nbsp;Promo Bebas Ongkir sampai dengan Rp 30.000 dengan minimum pembelian Rp 199.000.</li>
        <li>&#x2022; &nbsp;Berlaku untuk semua produk di Kinaras.</li>
        <li>&#x2022; &nbsp;Limit penggunaan voucher 1x/user.</li>
        <li>&#x2022; &nbsp;Selama kuota masih tersedia.</li>
      </ul>
    </div>
  </div>
</div>

    <div id="popup2" class="popup">
      <div class="popup-content">
        <span class="close" onclick="closePopup('popup2')">&times;</span>
        <h2>DAILY VOUCHER UP TO 100K</h2>
    <div class="popup-description">
      <h3>DESKRIPSI</h3>
      <p>Voucher diskon 10% hingga Rp 100.000!</p>
      <div class="popup-details">
        <div class="detail-item">
          <span>Minimum Transaksi</span>
          <span>Rp280.000</span>
        </div>
        <div class="detail-item">
          <span>Periode Promo</span>
          <span>10-16 Juli 2024</span>
        </div>
        <div class="detail-item">
          <span>Kode Promo</span>
          <span>DAILYTREAT</span>
          <button class="copy-code" onclick="copyCode('DAILYTREAT')">SALIN KODE</button>
        </div>
      </div>
    </div>
    <div class="popup-terms">
      <h3>SYARAT & KETENTUAN</h3>
      <ul>
        <li>&#x2022; &nbsp;Voucher diskon hingga Rp 100.000 dengan minimum belanja Rp 280.000.</li>
        <li>&#x2022; &nbsp;Berlaku untuk pembelanjaan semua produk.</li>
        <li>&#x2022; &nbsp;Limit penggunaan voucher 1x/user.</li>
        <li>&#x2022; &nbsp;Kuota voucher terbatas.</li>
      </ul>
    </div>
  </div>
</div>

    <div id="popup3" class="popup">
      <div class="popup-content">
        <span class="close" onclick="closePopup('popup3')">&times;</span>
        <h2>DAILY VOUCHER UP TO 30K</h2>
    <div class="popup-description">
      <h3>DESKRIPSI</h3>
      <p>Voucher diskon hingga Rp 30.000!</p>
      <div class="popup-details">
        <div class="detail-item">
          <span>Minimum Transaksi</span>
          <span>Rp150.000</span>
        </div>
        <div class="detail-item">
          <span>Periode Promo</span>
          <span>10-16 Juli 2024</span>
        </div>
        <div class="detail-item">
          <span>Kode Promo</span>
          <span>DAILYDISC</span>
          <button class="copy-code" onclick="copyCode('DAILYDISC')">SALIN KODE</button>
        </div>
      </div>
    </div>
    <div class="popup-terms">
      <h3>SYARAT & KETENTUAN</h3>
      <ul>
        <li>Voucher diskon 8% hingga Rp 30.000 dengan minimum belanja Rp 280.000.</li>
        <li>Berlaku untuk pembelanjaan semua produk.</li>
        <li>Limit penggunaan voucher 1x/user.</li>
        <li>Kuota voucher terbatas.</li>
      </ul>
    </div>
  </div>
</div>
      
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
