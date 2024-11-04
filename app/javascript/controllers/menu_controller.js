import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  open() {
    this.menuTarget.classList.remove("translate-x-full")
    this.menuTarget.classList.add("translate-x-0")
  }

  close() {
    this.menuTarget.classList.remove("translate-x-0")
    this.menuTarget.classList.add("translate-x-full")
  }
}
