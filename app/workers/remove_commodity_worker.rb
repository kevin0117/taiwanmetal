class RemoveCommodityWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3

  def perform(commodity_id)
    commodity = Commodity.find(commodity_id)

    html = "commodity_#{commodity.id}"
    closed = CommoditiesController.render(
      partial: 'closed_commodity', 
      locals: { commodity: commodity }
    ).squish
    
    ActionCable.server.broadcast "board", deal: html, closed: closed   
  end
end