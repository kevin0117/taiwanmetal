import { Controller } from "stimulus";
import Rails from "@rails/ujs";


export default class extends Controller { 
  static targets = [ "weight", "service_fee", "gold_selling", 
                     "exchange_weight", "wastage_rate", 
                     "net_weight", "gold_buying", "total_price", 
                     "scrap_weight", "collected_date", 
                     "customer_id", "user_id" ] 
 
  cal_weight(event) {
    event.preventDefault()

    let exchange_weight = this.exchange_weightTarget.value
    let wastage_rate = this.wastage_rateTarget.value
    let net_weight = this.net_weightTarget.value
    let weight = parseFloat(this.weightTarget.value)
    let pure_weight = Math.floor((exchange_weight * wastage_rate)*100)/100
    this.net_weightTarget.value = pure_weight
    let scrap_weight =  Math.round((pure_weight - weight)*100)/100
    this.scrap_weightTarget.value = scrap_weight

  }

  to_scrap(event) {
    event.preventDefault();
    let collected_date = this.collected_dateTarget.value
    let customer_id = this.customer_idTarget.value
    let gross_weight = this.exchange_weightTarget.value
    let wastage_rate = this.wastage_rateTarget.value
    let net_weight = this.net_weightTarget.value
    let weight = parseFloat(this.weightTarget.value)
    let exchange_weight = this.exchange_weightTarget.value
    let gold_buying = parseFloat(this.gold_buyingTarget.value)
    let pure_weight = Math.floor((exchange_weight * wastage_rate)*100)/100
    let scrap_weight =  Math.round((pure_weight - weight)*100)/100
    let user_id = this.user_idTarget.value
    
    console.log(scrap_weight)

    // let email = this.emailTarget.value.trim();
    let data = new FormData();
    data.append("transfer[collected_date]", collected_date);
    data.append("transfer[customer_id]", customer_id);
    data.append("transfer[gross_weight]", gross_weight);
    data.append("transfer[wastage_rate]", wastage_rate);
    data.append("transfer[net_weight]", net_weight);
    data.append("transfer[scrap_weight]", scrap_weight);
    data.append("transfer[gold_buying]", gold_buying);
    data.append("transfer[user_id]", user_id);




    Rails.ajax({
      url: '/api/v1/transfer', 
      data: data,
      type: 'POST', 
      dataType: 'json', 
      success: (response) => {
        switch (response.status) {
          case 'ok':
            alert('完成入庫!');
            
            break;

          case 'fail':
            alert('入庫失敗!');
            break;
        }
      }, 
      error: function(err) {
        console.log(err);
      }
    });
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

    if (total_weight >= 0) {
      let result_price = (service_fee + total_weight * gold_selling) 
      this.total_priceTarget.value = result_price.toFixed(0)
    
    } else {
      let result_price = (Math.abs(total_weight) * gold_buying - service_fee) * -1
      this.total_priceTarget.value = result_price.toFixed(0)
    }
  }
}