import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "This is lazy loaded with an Stimulus controller"
  }
}
