<?php
session_start();
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Our Store</title>
    <link rel="stylesheet" href="css/ourstore.css" />
    <link rel="stylesheet" href="css/style.css" />

    <!-- icon -->
    <link
      rel="shortcut icon"
      href="images/icons/icon.ico"
      type="image/x-icon"
    />
    
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

    <!-- Header -->
    <?php include ("header.php");?>
    <?php include ("sidecategory.php");?>

    <div class="pv-container">
    <div class="container">
     <!--Content-->

     <!-- Banner -->
    <section id="store-banner" style="background-image: url('images/store2.jpg');"  class="section-m1">
        <h2>Find Kinaras Store</h4>
    </section><br>

    <section id="store-locations" class="section-m1">
        <div class="store-card">
            <img src="images/store1.jpg" alt="Kinaras Plaza Ambarrukmo Yogyakarta">
            <div class="store-info">
                <h3>Kinaras Plaza Ambarrukmo Yogyakarta</h3>
                <p>Kinaras Plaza Ambarrukmo Lt.1 Laksda Adisucipto No.80, Kec. Depok, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55281</p>
                <p>Senin - Minggu</p>
                <p>10:00 - 22:00</p>
                <a href="#" class="btn-directions">DIRECTIONS</a>
            </div>
        </div>
        <div class="store-card">
            <img src="images/store2.jpg" alt="Kinaras Jogja City Mall">
            <div class="store-info">
                <h3>Kinaras Jogja City Mall</h3>
                <p>Kinaras Jogja City Mall Lantai 1 Jl. Magelang No.18, Kutu Patran, Sinduadi, Kec. Mlati, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55284</p>
                <p>Senin - Minggu</p>
                <p>10:00 - 22:00</p>
                <a href="#" class="btn-directions">DIRECTIONS</a>
            </div>
        </div>
        <div class="store-card">
            <img src="images/store3.jpg" alt="Kinaras Pakuwon Mall Solo Baru">
            <div class="store-info">
                <h3>Kinaras Pakuwon Mall Solo Baru</h3>
                <p>Kinaras Pakuwon Mall Solo Baru Lt. UG Jl. Ir. Soekarno, Madegondo, Grogol, Kabupaten Sukoharjo, Jawa Tengah 57552</p>
                <p>Senin - Minggu</p>
                <p>10:00 - 22:00</p>
                <a href="#" class="btn-directions">DIRECTIONS</a>
            </div>
        </div>
        <div class="store-card">
            <img src="images/store4.jpg" alt="Kinaras Solo Paragon">
            <div class="store-info">
                <h3>Kinaras Solo Paragon</h3>
                <p>Kinaras Solo Paragon Mall Lt. 3, Jl. Yosodipuro No.133, Mangkubumen, Kec. Banjarsari, Kota Surakarta, Jawa Tengah 57139</p>
                <p>Senin - Minggu</p>
                <p>10:00 - 22:00</p>
                <a href="#" class="btn-directions">DIRECTIONS</a>
            </div>
        </div>
    </section>
    </div>
    </div><br>
      
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
  </body>
</html>