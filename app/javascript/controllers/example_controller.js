import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="example"
export default class extends Controller {
  static targets = ["params"]
  connect() {
        console.log("connect")

  }
}
