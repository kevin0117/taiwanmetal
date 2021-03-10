module CurrentPrice

  private

  def show_price
    require 'net/http'
    require 'json'

    access_key = ENV['ACCESS_KEY']
    overhead = ENV['OVERHEAD'].to_i
    agio = ENV['AGIO'].to_i
    us_agio = ENV['US_AGIO'].to_i
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
    begin
      @response = Net::HTTP.get(@uri)
      puts "@response: " + @response
    rescue SocketError => error
      puts error.inspect
      puts "check your internet connection"
    end
    # @response: {"success":false,"error":{"code":104,"type":"request_limit_reached","info":"The maximum allowed API amount of monthly API requests has been reached."}}
    # byebug
    if  @response.nil? || @response.include?("error")
      @XAU_TWD_SELL = 0
      @XAU_TWD_BUY = 0
    else
      @XAU_TWD_SELL = (JSON.parse(@response)["rates"]["XAU"]/ratio - overhead).to_i
      @XAU_TWD_BUY = @XAU_TWD_SELL - agio
    end
    # @XAU_TWD_SELL = 0 || (JSON.parse(@response)["rates"]["XAU"]/ratio - overhead).to_i
    # @XAU_TWD_BUY = @XAU_TWD_SELL - agio

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
    begin
      @response1 = Net::HTTP.get(@uri1)
      puts "@response1: " + @response1
    rescue SocketError => error
      puts error.inspect
      puts "check your internet connection"
    end

    if @response.nil? || @response1.include?("error")
      @XAU_USD_SELL = 0
      @XAU_USD_BUY = 0
    else
      @XAU_USD_SELL = (ratio1 / JSON.parse(@response1)["rates"]["XAU"]).to_f.round(1)
      @XAU_USD_BUY = @XAU_USD_SELL - us_agio
    end
    # @XAU_USD_SELL = 0 || (ratio1 / JSON.parse(@response1)["rates"]["XAU"]).to_f.round(1)
    # @XAU_USD_BUY = @XAU_USD_SELL - 0.5
  end
end