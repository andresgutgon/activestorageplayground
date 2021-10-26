import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autoupload"
export default class extends Controller {
  onUpload () {
    this.element.submit()
  }
}
