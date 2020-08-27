import { Controller } from "stimulus" 

export default class extends Controller { 
  static targets = [ "weight", "unit_price", "total_price" ] 

  cal_total_price(event) {
    event.preventDefault();
    let weight = this.weightTarget.value
    let unit_price = this.unit_priceTarget.value

    let total_price = (weight * unit_price).toFixed(0)
    
    console.log(weight)
    console.log(unit_price)
    console.log(total_price)
    this.total_priceTarget.value = total_price
  }

  connect() {
    console.log("connect to commodity")
  }
}