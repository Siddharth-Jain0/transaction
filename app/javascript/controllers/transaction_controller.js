import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(){
    console.log("hello")
  }
  initialize() {
    this.element.setAttribute("data-action", "change->transaction#status")
  }
  status(){
    const selectedstatus = this.element.options[this.element.selectedIndex].value
    console.log(selectedstatus)
  }
}