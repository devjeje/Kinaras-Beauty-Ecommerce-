<?php
session_start();
include "koneksi.php";
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bag</title>
    <link rel="stylesheet" href="css/style.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
    <!-- Header -->
    <?php include "header.php"; ?>
    <?php include "sidecategory.php";?>
  <main>
    <div class="card">
    <div class="container">
     <!--Content-->  
     <!-- cart + summary -->
<section class="bg-light my-5">
  <div class="container">
  <div class="row">
  <!-- cart -->
  <div class="col-lg-9">
    <div class="card border shadow-0">
      <div class="m-4">
        <h4 class="card-title mb-4">Your shopping bag</h4>
        <?php 
        if (!isset($_SESSION['user_id'])) { 
         ?> <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;">
            <img src="images/icons/empty-bag.png" alt="empty-bag" width="140px" height="auto">
            <p style="text-align: center;" ><b>Your bag is empty.</b></p>
          </div>
        <?php } else {
          $id = $_SESSION['user_id'];    
          $qry = "CALL show_product_cart('$id');";
          $qry2 = "SELECT count_total_cart('$id') AS total_cart;";
          $sql2 = mysqli_query($conn, $qry2);
          $result2 = mysqli_fetch_assoc($sql2);
          $total_cart = $result2['total_cart'];
          $sql = mysqli_query($conn, $qry);
          $data = [];
          while($row = mysqli_fetch_assoc($sql)) {
              $data[] = $row;
        }

         $_SESSION['cartlist'] = $data;

        if (!empty($data)) : 
        foreach ($data as $list) : ?>
        <div class="row gy-3 mb-4">
          <div class="col-lg-5">
            <div class="me-lg-5">
              <div class="d-flex">
                <img src="dashboard/<?= $list['product_img']?>" class="border rounded me-3" style="width: 96px; height: 96px;" />
                <div>
                  <a href="#" class="nav-link"><b><?= htmlspecialchars($list['brand']) ?></b></a>
                  <p class="text-muted"><?= htmlspecialchars($list['product_name']) ?></p>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-2 col-sm-6 col-6 d-flex flex-row flex-lg-column flex-xl-row text-nowrap">
            <div>
              <select style="width: 100px;" class="form-select me-4">
                <option>1</option>
              </select>
            </div>
            <div>
              <text class="h6">Rp <?php echo number_format($list['price'], 0, ',', '.'); ?></text> <br />
              <small class="text-muted text-nowrap"> Rp <?php echo number_format($list['price'], 0, ',', '.'); ?> / per item </small>
            </div>
          </div>
          <div class="col-lg col-sm-6 d-flex justify-content-sm-center justify-content-md-start justify-content-lg-center justify-content-xl-end mb-2">
            <div class="float-md-end">
              <form method="POST" action="aksi_hapus_cart.php">
                <input type="hidden" id="bag_id" name="bag_id" value="<?php echo $list['bag_id'];?>">
                <button type="submit" class="btn btn-light border text-danger icon-hover-danger"> Remove</button>
              </form>
            </div>
          </div>
        </div>
        <?php endforeach; ?>
        <div class="border-top pt-4 mx-4 mb-4">
          <p><i class="fas fa-truck text-muted fa-lg"></i><b>Shipping Address</b></p>
          <p class="text-muted"></p>
          <form id="shipping-form">
            <div class="row">
              <div class="form-group col-md-6">
                <label for="name">Nama Penerima:</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="John Doe" required>
              </div>
              <div class="form-group col-md-6">
                <label for="nohp">No. Handphone:</label>
                <input type="text" class="form-control" id="nohp" name="nohp" placeholder="contoh: 62813738763" required>
              </div>
            </div>
            <div class="row">
              <div class="form-group col-md-6">
                <label for="country">Negara:</label>
                <select id="country" class="form-control" name="country" onchange="updateProvince()" required>
                  <option value="Indonesia">Indonesia</option>
                </select>
              </div>
              <div class="form-group col-md-6">
                <label for="province">Provinsi:</label>
                <select class="form-control" id="province" name="province" onchange="updateCity()" required>
                  <option value="">Pilih provinsi</option>
                </select>
              </div>
            </div>
            <div class="row">
              <div class="form-group col-md-6">
                <label for="city">City:</label>
                <select id="citySelect" class="form-control" name="city" required>
                  <option value="">Pilih kabupaten/kota</option>
                </select>
              </div>
              <div class="form-group col-md-6">
                <label for="courier">Ekspedisi:</label>
                <select id="courier" class="form-control" name="courier" onchange="calculateShipping()" required>
                  <option value="">Pilih ekspedisi</option>
                  <option value="jne">JNE</option>
                  <option value="tiki">TIKI</option>
                  <option value="pos">POS Indonesia</option>
                </select>
              </div>
              <div class="form-group col-md-6">
                <label for="postal-code">Kode pos:</label>
                <input type="text" class="form-control" id="postal-code" name="postal-code" placeholder="" required>
              </div>
              <div class="form-group col-md-6">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="cust_address" name="address" placeholder="Enter your address" required>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- cart -->
  <!-- summary -->
  <div class="col-lg-3">
    <div class="card mb-3 border shadow-0">
      <div class="card-body">
        <form>
          <div class="form-group">
            <label class="form-label">Have coupon?</label>
            <div class="input-group">
              <input type="text" class="form-control border" name="" placeholder="Coupon code" />
              <button class="btn btn-light border">Apply</button>
            </div>
          </div>
        </form>
      </div>
    </div>
    <div class="card shadow-0 border">
      <div class="card-body">
       <!-- Form Pembayaran -->
        <form id="payment-form" method="POST" action="process_payment.php">
            <div class="d-flex justify-content-between">
                <p class="mb-2">Harga item:</p>
                <p class="mb-2" id="total-item">Rp. <?= $total_cart ?></p>
                <input type="hidden" id="simpan_value_total-item" value="<?= $total_cart ?>">
            </div>
            <div class="d-flex justify-content-between">
                <p class="mb-2" style="display:none;" id="display-info">Ongkir:</p>
                <p class="mb-2" id="shipping-cost"></p>
                <input type="hidden" name="simpan_ongkir" id="simpan_value_ongkir" value="<?= $shipping_cost ?>">
            </div>
            <hr />
            <div class="d-flex justify-content-between">
                <p class="mb-2">Total Harga:</p>
                <p class="mb-2 fw-bold" id="final-total-price"></p>
                <input type="hidden" name="final-total-price" id="hidden-final-total-price" value="">
                <input type="hidden" name="gross_amount" id="hidden-gross-amount" value="">
            </div>
            <div class="mt-3">
                <input type="hidden" name="name" id="hidden-name" value="">
                <input type="hidden" name="nohp" id="hidden-nohp" value="">
                <input type="hidden" name="address" id="hidden-address" value="">
                <input type="hidden" name="total-item" id="hidden-total-item" value="">
                <input type="hidden" name="shipping-cost" id="hidden-shipping-cost" value="">
                <button type="button" id="pay-button" class="btn btn-success w-100 shadow-0 mb-2" style="background-color: #eb375e; border-color: #FA8072;">Payment</button>
            </div>
        </form>
        <a href="index.php" class="btn btn-light w-100 border mt-2">Back to shop</a>
      </div>
    </div>
  </div>
  <?php else: ?>
  <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;">
    <img src="images/icons/empty-bag.png" alt="empty-bag" width="140px" height="auto">
    <p style="text-align: center;" ><b>Your bag is empty.</b></p>
  </div>
  <?php endif; 
        
  }?>
  
    </div>
    </div>
      <!-- summary -->
      </div>
     </div>
    </section>
  </main>
      
     <!-- Footer -->
    <?php include "footer.php";?>
    
   <!-- Javascript -->
   <!-- <script src="js/function.js"></script> -->
    <script src="js/script.js"></script>
    <script src="js/function.js"></script>

  <!-- Midtrans -->
<script src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="SB-Mid-client-6gSQdoeYFDuygK5f"></script>
<script type="text/javascript">
    document.getElementById('pay-button').onclick = function(event){
        event.preventDefault();

        var name = document.getElementById('name').value;
        var nohp = document.getElementById('nohp').value;
        var address = document.getElementById('cust_address').value;
        var totalItem = parseInt(document.getElementById('simpan_value_total-item').value) || 0;
        var shippingCost = parseInt(document.getElementById('simpan_value_ongkir').value) || 0;

        var grossAmount = totalItem + shippingCost;

        document.getElementById('hidden-name').value = name;
        document.getElementById('hidden-nohp').value = nohp;
        document.getElementById('hidden-address').value = address;
        document.getElementById('hidden-total-item').value = totalItem;
        document.getElementById('hidden-shipping-cost').value = shippingCost;
        document.getElementById('hidden-gross-amount').value = grossAmount;

        var form = document.getElementById('payment-form');
        var formData = new FormData(form);

        fetch('process_payment.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.token) {
                snap.pay(data.token);
            } else {
                console.error('Error:', data.error);
            }
        })
        .catch(error => console.error('Error:', error));
    };
</script>
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