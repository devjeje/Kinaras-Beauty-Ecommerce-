"use strict";

// mobile menu variables
const mobileMenuOpenBtn = document.querySelectorAll(
  "[data-mobile-menu-open-btn]"
);
const mobileMenu = document.querySelectorAll("[data-mobile-menu]");
const mobileMenuCloseBtn = document.querySelectorAll(
  "[data-mobile-menu-close-btn]"
);

const overlay = document.querySelector("[data-overlay]");

for (let i = 0; i < mobileMenuOpenBtn.length; i++) {
  // mobile menu function
  const mobileMenuCloseFunc = function () {
    mobileMenu[i].classList.remove("active");
    overlay.classList.remove("active");
  };

  mobileMenuOpenBtn[i].addEventListener("click", function () {
    mobileMenu[i].classList.add("active");
    overlay.classList.add("active");
  });

  mobileMenuCloseBtn[i].addEventListener("click", mobileMenuCloseFunc);
  overlay.addEventListener("click", mobileMenuCloseFunc);
}
// PROFILE TOGGLE
function profileToggle() {
  const toggleMenu = document.querySelector(".menu");
  if (toggleMenu) {
    toggleMenu.classList.toggle("active");
  }
}
// MOBILE PROFILE TOGGLE
function mobileprofileToggle() {
  const toggleMenu = document.querySelector(".profile-menu-mobile");
  if (toggleMenu) {
    toggleMenu.classList.toggle("active");
  }
}
// accordion variables
const accordionBtn = document.querySelectorAll("[data-accordion-btn]");
const accordion = document.querySelectorAll("[data-accordion]");

for (let i = 0; i < accordionBtn.length; i++) {
  accordionBtn[i].addEventListener("click", function () {
    const clickedBtn = this.nextElementSibling.classList.contains("active");

    for (let i = 0; i < accordion.length; i++) {
      if (clickedBtn) break;

      if (accordion[i].classList.contains("active")) {
        accordion[i].classList.remove("active");
        accordionBtn[i].classList.remove("active");
      }
    }

    this.nextElementSibling.classList.toggle("active");
    this.classList.toggle("active");
  });
}

// JavaScript to handle popup display
document.addEventListener("DOMContentLoaded", function () {
  function openPopup(popupId) {
    var popup = document.getElementById(popupId);
    popup.style.display = "flex";
  }

  function closePopup(popupId) {
    var popup = document.getElementById(popupId);
    popup.style.display = "none";
  }

  var promoCardItems = document.querySelectorAll(".promo-card-item");
  promoCardItems.forEach(function (item) {
    item.addEventListener("click", function () {
      var popupId = this.getAttribute("onclick").match(/'([^']+)'/)[1];
      openPopup(popupId);
    });
  });

  var closeButtons = document.querySelectorAll(".popup .close");
  closeButtons.forEach(function (button) {
    button.addEventListener("click", function () {
      var popupId = this.parentElement.parentElement.id;
      closePopup(popupId);
    });
  });

  window.addEventListener("click", function (event) {
    var popups = document.querySelectorAll(".popup");
    popups.forEach(function (popup) {
      if (event.target == popup) {
        popup.style.display = "none";
      }
    });
  });
});
