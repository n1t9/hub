import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "menubg"]

  open() {
    this.menuTarget.classList.remove("translate-x-full")
    this.menuTarget.classList.add("translate-x-0")
    this.menubgTarget.classList.remove("hidden")
  }

  close() {
    this.menuTarget.classList.remove("translate-x-0")
    this.menuTarget.classList.add("translate-x-full")
    this.menubgTarget.classList.add("hidden")
  }
}
