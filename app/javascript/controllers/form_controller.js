import { Controller } from "stimulus"
import Rails from "@rails/ujs";


export default class extends Controller {
  static targets = [ "gross_weight", "net_weight", "gold_buying", "wastage_rate", "total_price", "cal_weight", "cal_amount" ]
  cal_weight(event) {
    event.preventDefault();
    let gross_weight = this.gross_weightTarget.value
    let wastage_rate = this.wastage_rateTarget.value
    let pure_weight = Math.floor((gross_weight * wastage_rate)*100)/100

    this.net_weightTarget.value = pure_weight
  }

  cal_amount(event) {
    event.preventDefault();
    let gross_weight = this.gross_weightTarget.value
    let wastage_rate = this.wastage_rateTarget.value
    let gold_buying = this.gold_buyingTarget.value
    let pure_weight = Math.floor((gross_weight * wastage_rate)*100)/100
    let price_amount = (pure_weight * gold_buying).toFixed(0)
    
    this.total_priceTarget.value = price_amount
  }
}
