// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log(" DropdownController connecté sur :", this.element)

    this.outsideClick = (event) => {
      if (!this.element.contains(event.target)) {
        this.element.classList.remove("open")
      }
    }

    document.addEventListener("click", this.outsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.outsideClick)
  }

  toggle(event) {
    event.stopPropagation()
    this.element.classList.toggle("open")

    console.log("▶ toggle :", this.element.classList.contains("open") ? "OUVERT" : "FERMÉ")
  }
}
