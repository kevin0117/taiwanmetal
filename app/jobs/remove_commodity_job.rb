class RemoveCommodityJob < ApplicationJob
  queue_as :default

  def perform(commodity)
    
    html = "commodity_#{commodity.id}"
    
    ActionCable.server.broadcast "board", deal: html   
  end
end
