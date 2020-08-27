import consumer from "./consumer"

consumer.subscriptions.create("BoardChannel", {
  connected() {
    console.log("Connected to Board channel")
    // Called when the subscription is ready for use on the server
  },
  
  received(data) {
    // Called when there's incoming data on the websocket for this channel
    
    const commodityContainer = document.getElementById('commodities')
    const commodityRecord = document.getElementById(data.deal)

    // console.log(data.deal)

    // data['deal'] is equal to data.deal 
    if (data['deal']!= undefined) 
      commodityRecord.innerText='';      
    else
      commodityContainer.innerHTML = data.html + commodityContainer.innerHTML; 
  }
});

