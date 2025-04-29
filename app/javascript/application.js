// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@popperjs/core"

document.addEventListener("turbo:load", () => {
  const loginModal = document.getElementById("loginModal");

  if (loginModal) {
    const bootstrapModal = new bootstrap.Modal(loginModal);

    loginModal.addEventListener("show.bs.modal", () => {
      loginModal.classList.add("sabre-open");
    });

    loginModal.addEventListener("hidden.bs.modal", () => {
      loginModal.classList.remove("sabre-open");
    });
  }
});

