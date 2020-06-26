import { Controller } from "stimulus" 

export default class extends Controller { 
  static targets = [ "weight", "service_fee", "gold_selling", "exchange_weight", "wastage_rate", "net_weight", "gold_buying", "total_price" ] 

  cal_weight(event) {
    event.preventDefault()

    let exchange_weight = this.exchange_weightTarget.value
    let wastage_rate = this.wastage_rateTarget.value
    let net_weight = this.net_weightTarget.value
    // let price = this.gold_priceTarget.value

    let pure_weight = Math.floor((exchange_weight * wastage_rate)*100)/100
    this.net_weightTarget.value = pure_weight
  }

  calculate(event) {
    event.preventDefault()

    let weight = parseFloat(this.weightTarget.value)
    let service_fee = parseFloat(this.service_feeTarget.value)
    let gold_selling = parseFloat(this.gold_sellingTarget.value)
    let exchange_weight = parseFloat(this.exchange_weightTarget.value)
    let wastage_rate = parseFloat(this.wastage_rateTarget.value)
    let net_weight = parseFloat(this.net_weightTarget.value)
    let gold_buying = parseFloat(this.gold_buyingTarget.value)
    let total_price = this.total_priceTarget.value

    let pure_weight = Math.floor((exchange_weight * wastage_rate)*100)/100
    let total_weight = (weight - net_weight)
    this.net_weightTarget.value = pure_weight
    // this.gold_priceTarget.value = result
    // this.weightTarget.value = total_weight
    console.log(weight)
    console.log(pure_weight)
    console.log(total_weight)


    // console.log(service_fee + total_weight * gold_selling)
    if (total_weight >= 0) {
      let result_price = (service_fee + total_weight * gold_selling) 
      this.total_priceTarget.value = result_price.toFixed(0)
      // console.log("hi")
    } else {
      let result_price = (Math.abs(total_weight) * gold_buying - service_fee) * -1
      this.total_priceTarget.value = result_price.toFixed(0)
    }
  }
}