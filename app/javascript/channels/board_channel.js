import consumer from "./consumer"

consumer.subscriptions.create("BoardChannel", {
  connected() {
    console.log("Connected to Board channel")
    // Called when the subscription is ready for use on the server
  },
  
  received(data) {
    // Called when there's incoming data on the websocket for this channel
    
    const commodityContainer = document.getElementById('commodities')
    const closed_commodityContainer = document.getElementById('closed_commodities')
    const commodityRecords = document.getElementsByClassName(data.deal)
    
    // data['deal'] is equal to data.deal
    // if the "deal" key can't be find in data hash, javascript will return "undefined" 
    // it means the create action is required, and vice versa 
    if (data['deal']!= undefined) { 
      var i = 0;
      do {
        commodityRecords[i].innerText='';
        i += 1;
        console.log(i);
      } while (i < commodityRecords.length);
      closed_commodityContainer.innerHTML = data.closed + closed_commodityContainer.innerHTML; 

    }
    else
      commodityContainer.innerHTML = data.html + commodityContainer.innerHTML; 
  }
});

