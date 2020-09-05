class SendCommodityWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false
  # sidekiq_options :queue => :default, :retry => 3
  def perform(commodity_id)
    commodity = Commodity.find(commodity_id)
    
    html = CommoditiesController.render(
      partial: 'commodity', 
      locals: { commodity: commodity }
    ).squish
    ActionCable.server.broadcast "board", html: html  
  end
end
