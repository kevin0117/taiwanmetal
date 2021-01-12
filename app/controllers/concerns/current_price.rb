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
    puts "@response: " + @response

    @XAU_TWD_SELL = (JSON.parse(@response)["rates"]["XAU"]/ratio - overhead).to_i
    @XAU_TWD_BUY = @XAU_TWD_SELL - agio

    currency1 = 'USD'
    ratio1 = 1

    @url1 = 'https://metals-api.com/api/' +
    endpoint +
    '?access_key=' +
    access_key +
    '&base=' +
    currency1 +
    '&symbols=' +
    symbols

    @uri1 = URI(@url1)
    @response1 = Net::HTTP.get(@uri1)
    puts "@response1: " + @response1
    @XAU_USD_SELL = (ratio1 / JSON.parse(@response1)["rates"]["XAU"]).to_f.round(1)
    @XAU_USD_BUY = @XAU_USD_SELL - 0.5
  end
end
# # // "latest" endpoint - request the most recent exchange rate data

#   https://metals-api.com/api/latest

#       ? access_key = YOUR_ACCESS_KEY
#       & base = USD
#       & symbols = XAU,XAG