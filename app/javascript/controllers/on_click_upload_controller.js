import { Controller } from "@hotwired/stimulus"

/**
 * Connects to data-controller="on_click_upload"
 * With this controller when a user click an input type='file' that
 * is inside a form it will trigger a form submit automaticaly
 * This is helpful when there is only the input type='file' in that
 * form. Like an update avatar element
 */
export default class extends Controller {
  onUpload (_event) {
    this.element.submit()
  }
}
