class RemoveCommodityJob < ApplicationJob
  queue_as :default

  def perform(commodity)
    
    html = "commodity_#{commodity.id}"
    closed = CommoditiesController.render(
      partial: 'closed_commodity', 
      locals: { commodity: commodity }
    ).squish
    
    ActionCable.server.broadcast "board", deal: html, closed: closed   
  end
end
