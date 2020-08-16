class Api::V1::UtilsController < ApplicationController
  def subscribe
    email = params['subscribe']['email']
    sub = Subscribe.new(email: email)

    if sub.save
      render json: { status: 'ok', email: email }
    else
      render json: { status: 'duplicated', email: email }
    end
  end

  def transfer
    collected_date = params['transfer']['collected_date']
    customer_id = params['transfer']['customer_id']
    title = '換金'
    gross_weight = (params['transfer']['gross_weight']).to_f
    wastage_rate = (params['transfer']['wastage_rate']).to_f
    net_weight = (params['transfer']['net_weight']).to_f
    gold_buying = (params['transfer']['gold_buying']).to_i
    total_price = net_weight * gold_buying
    user_id = params['transfer']['user_id']
    
    scrap = Scrap.new(collected_date: collected_date,
                      title: title, 
                      gross_weight: gross_weight,
                      wastage_rate: wastage_rate,
                      net_weight: net_weight,
                      gold_buying: gold_buying,
                      customer_id: customer_id,
                      user_id: user_id)

    if scrap.save
      render json: { status: 'ok' }
    else
      render json: { status: 'fail' }
    end
    
  end
end