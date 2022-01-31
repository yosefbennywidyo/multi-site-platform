import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["transaction_price"]

  change(event) {
    let product_id = event.target.selectedOptions[0].value
    let target = this.transaction_priceTarget.price
    console.log((product_id))
    get('/get_price?target=${target}&product_id=${product_id}'), {
      responseKind: "turbo-stream"
    }
  }
}
