import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "weight", "service_fee", "total_weight", "quantity", "total_service_fee", "template", "link" ]

  cal_total_weight(event) {
    event.preventDefault();

    let weight = this.weightTarget.value
    let service_fee = this.service_feeTarget.value
    let quantity = this.quantityTarget.value

    let total_weight = (weight * quantity).toFixed(2)
    let total_service_fee = (service_fee * quantity).toFixed(2)

    console.log(weight)
    console.log(total_service_fee)
    console.log(quantity)
    console.log(total_weight)

    this.total_weightTarget.value = total_weight
    this.total_service_feeTarget.value = total_service_fee
  }
}