import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "gross_weight", "net_weight", "gold_buying", "wastage_rate", "total_price", "cal_weight", "cal_amount", "collected_date" ]
  
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

  get_price(event) {
    event.preventDefault();

    let collected_date = this.collected_dateTarget.value.trim();
    let data = new FormData();
    data.append("get_price[collected_date]", collected_date);
    console.log(collected_date)
    Rails.ajax({
      url: '/api/v1/get_price',
      data: data,
      type: 'POST',
      dataType: 'json',
      success: (response) => {
        switch (response.status) {
          case 'ok':
            this.gold_buyingTarget.value = response.buying_price;
            break;

          case 'fail':
            alert('該日金價未設定');
            this.gold_buyingTarget.value = response.buying_price;
            break;
        }
      },
      error: function(err) {
        console.log(err);
      }
    });
  }
}
