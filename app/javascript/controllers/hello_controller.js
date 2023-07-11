import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = [ "upi" , "search"]
 
  verify() {
    const element = this.upiTarget
    const input = element.value
    console.log(`Hello, ${input}!`)
    this.url = `/transaction_histories/verify?upi=${input}` 
    fetch(this.url,{
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))

  }
  selectstatus(){
    const element = document.getElementById("status").value
    console.log(element)
    this.url = `/transaction_histories/specific_transactions?status=${element}`
    fetch(this.url,{
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
  search(){
    const element = this.searchTarget
    const input = element.value
    console.log(`Hello, ${input}!`)
    this.url = `/transaction_histories/search?find=${input}` 
    fetch(this.url,{
        headers: {
          Accept: "text/vnd.turbo-stream.html"
        }
      })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))


  }
}
  
  

  


