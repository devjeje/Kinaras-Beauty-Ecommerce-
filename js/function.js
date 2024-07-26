// Fungsi untuk mengambil data provinsi dari proxy
function updateProvince() {
  fetch("proxy.php?type=province")
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      return response.json();
    })
    .then((data) => {
      if (!data.rajaongkir || !data.rajaongkir.results) {
        throw new Error("Invalid data format");
      }
      let provinces = data.rajaongkir.results;
      let provinceSelect = document.getElementById("province");
      provinceSelect.innerHTML = '<option value="">Pilih provinsi</option>';
      provinces.forEach((province) => {
        provinceSelect.innerHTML += `<option value="${province.province_id}">${province.province}</option>`;
      });
    })
    .catch((error) => {
      console.error("There was a problem with the fetch operation:", error);
    });
}

// Fungsi untuk mengambil data kota berdasarkan provinsi yang dipilih dari proxy
function updateCity() {
  let provinceId = document.getElementById("province").value;
  fetch(`proxy.php?type=city&province=${provinceId}`)
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      return response.json();
    })
    .then((data) => {
      if (!data.rajaongkir || !data.rajaongkir.results) {
        throw new Error("Invalid data format");
      }
      let cities = data.rajaongkir.results;
      let citySelect = document.getElementById("citySelect");
      citySelect.innerHTML = '<option value="">Pilih kabupaten/kota</option>';
      cities.forEach((city) => {
        citySelect.innerHTML += `<option value="${city.city_id}">${city.city_name}</option>`;
      });
    })
    .catch((error) => {
      console.error("There was a problem with the fetch operation:", error);
    });
}

// Fungsi untuk menghitung ongkir berdasarkan kota yang dipilih dan ekspedisi
function calculateShipping() {
  let cityId = document.getElementById("citySelect").value;
  let courier = document.getElementById("courier").value;

  fetch("calculate_shipping.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      cityId: cityId,
      courier: courier,
    }),
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      return response.json();
    })
    .then((data) => {
      if (!data.success) {
        throw new Error("Invalid data format");
      }
      let shippingCost = data.shippingCost;
      document.getElementById(
        "shipping-cost"
      ).innerText = `Rp. ${shippingCost}`;
      document.getElementById("display-info").style.display = "flex";
      document.getElementById("simpan_value_ongkir").value = shippingCost;
      // console.log(shippingCost);
      TotalBelanjaan();
    })
    .catch((error) => {
      console.error("There was a problem with the fetch operation:", error);
    });
}

// Panggil fungsi untuk mengisi data provinsi saat halaman dimuat
document.addEventListener("DOMContentLoaded", updateProvince);

// stock generator
document.addEventListener("DOMContentLoaded", function () {
  var orderCount = Math.floor(Math.random() * 2000) + 1;
  document.getElementById("order-count").textContent = orderCount + " orders";
});

function TotalBelanjaan() {
  let harga_item = parseInt(
    document.getElementById("simpan_value_total-item").value
  );
  let harga_ongkir = parseInt(
    document.getElementById("simpan_value_ongkir").value
  );
  let total_harga = harga_item + harga_ongkir;
  document.getElementById("final-total-price").innerText = `Rp. ${total_harga}`;
}
