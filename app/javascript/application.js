// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
console.log(" application.js chargé !");

import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import Swal from "sweetalert2"
window.Swal = Swal


document.addEventListener("turbo:load", () => {
  setTimeout(() => {
    document.querySelectorAll(".alert").forEach((el) => {
      el.classList.remove("show"); // supprime la classe "show"
      el.classList.add("fade");    // pour la transition
      setTimeout(() => el.remove(), 500); // supprime après l'animation
    });
  }, 5000);
});
