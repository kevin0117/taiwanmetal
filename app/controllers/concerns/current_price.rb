module CurrentPrice
  
  private
  
  def show_price
    require 'net/http'
    require 'json'

    access_key = ENV['ACCESS_KEY']
    overhead = ENV['OVERHEAD'].to_i 
    agio = ENV['AGIO'].to_i 
    ratio = 8.2943
    endpoint = 'latest'
    currency = 'TWD'
    symbols = 'XAU'

    @url = 'https://metals-api.com/api/' + 
           endpoint + 
           '?access_key=' + 
           access_key + 
           '&base=' + 
           currency +
           '&symbols=' + 
           symbols

    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @XAU_TWD_SELL = (JSON.parse(@response)["rates"]["XAU"]/ratio - overhead).to_i
    @XAU_TWD_BUY = @XAU_TWD_SELL - agio
  end
end