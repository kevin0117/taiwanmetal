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

  add_form(event) {
    event.preventDefault();

    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime());
    this.linkTarget.insertAdjacentHTML('beforebegin', content);

    console.log("OK");
  }
  remove_association(event) {
    event.preventDefault();
    let item = event.target.closest(".nested-fields")
    if (item.dataset.newRecord == 'true') {
      item.remove();
    } else {
      item.querySelector("input[name*='_destroy']").value = 1;
      item.style.display = 'none'
    }
  }
}