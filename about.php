<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kinaras About Us</title>
    <link rel="stylesheet" href="css/about.css" />

    <!-- icon -->
    <link
      rel="shortcut icon"
      href="images/icons/icon.ico"
      type="image/x-icon"
    />
    
  </head>
  <body>

    <!-- Header -->
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
              Beauty Blog
            </p>
          </div>

          <div class="header-top-actions">
            <select name="language">
              <option value="en-US">Indonesia</option>
              <option value="es-ES">English</option>
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
        </div>
      </div> 

         <!--Content-->
    <section class="content-slide">
      <section class="aboutus">
        <div class="about-box" data-aos="fade-down">
          <h1>About Us</h1>
        </div>
      </section>
      <section class="slider-container">
        <div class="slider-images">
          <div class="slider-img">
            <img src="images/Bim.png" alt="1" />
            <h5>Bima</h5>
            <div class="details">
              <h2>Bima Pratama</h2>
              <p>22.11.4547</p>
            </div>
          </div>
          <div class="slider-img">
            <img src="images/Zah.png" alt="2" />
            <h5>Zhazo</h5>
            <div class="details">
              <h2>Zahran Nugraha</h2>
              <p>22.11.4598</p>
            </div>
          </div>
          <div class="slider-img active">
            <img src="images/Uni.png" alt="3" />
            <h5>Euni</h5>
            <div class="details">
              <h2>Eunique Lydia Stephany</h2>
              <p>22.11.4545</p>
            </div>
          </div>
          <div class="slider-img">
            <img src="images/Zef.png" alt="4" />
            <h5>Zefan</h5>
            <div class="details">
              <h2>Zefantio</h2>
              <p>22.11.4580</p>
            </div>
          </div>
          <div class="slider-images">
            <div class="slider-img">
              <img src="images/Jo.png" alt="5" />
              <h5>Jodi</h5>
              <div class="details">
                <h2>Guruh Jodi Saputra</h2>
                <p>22.11.4569</p>
              </div>
            </div>
          </div>
        </div>
      </section>
    </section>

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

    <!-- slider animation -->
    <script src="js/jQuery.js"></script>
    <script>
      jQuery(document).ready(function ($) {
        $(".slider-img").on("click", function () {
          $(".slider-img").removeClass("active");
          $(this).addClass("active");
        });
      });
    </script>
  </body>
</html>
  </body>
</html>