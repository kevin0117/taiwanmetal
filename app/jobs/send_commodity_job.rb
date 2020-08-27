class SendCommodityJob < ApplicationJob
  queue_as :default

  def perform(commodity)
    # html = ApplicationController.render( 
    #   partial: 'commodities/commodity', 
    #   locals: { commodity: commodity }
    #   )
    # Above coding is working as well
    html = CommoditiesController.render(
      partial: 'commodity', 
      locals: { commodity: commodity }
    ).squish
    
    ActionCable.server.broadcast "board", html: html  
  end
end
