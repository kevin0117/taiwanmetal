class Api::V1::UtilsController < ApplicationController
  def get_price
    collected_date = params['get_price']['collected_date']
    target_record = PriceBoard.find_by(price_date: collected_date, user_id: current_user.id)

    if target_record.present?
      buying_price = target_record.gold_buying
      selling_price = target_record.gold_selling
      render json: { status: 'ok', buying_price: buying_price, selling_price: selling_price }
    else
      render json: { status: 'fail', buying_price: 0 }
    end
  end

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
    title = '待提煉換金-舊料'
    title1 = '待提煉換金-買料'
    gross_weight = (params['transfer']['gross_weight']).to_f
    scrap_weight = (params['transfer']['scrap_weight']).to_f
    wastage_rate = (params['transfer']['wastage_rate']).to_f
    net_weight = (params['transfer']['net_weight']).to_f
    gold_buying = (params['transfer']['gold_buying']).to_i
    total_price = (scrap_weight * gold_buying).round(2)
    user_id = params['transfer']['user_id']

    scrap = Scrap.new(collected_date: collected_date,
                      title: title,
                      gross_weight: gross_weight,
                      wastage_rate: wastage_rate,
                      net_weight: net_weight,
                      gold_buying: gold_buying,
                      customer_id: customer_id,
                      user_id: user_id)

    scrap1 = Scrap.new(collected_date: collected_date,
                       title: title1,
                       gross_weight: scrap_weight,
                       wastage_rate: 1.0,
                       net_weight: scrap_weight,
                       gold_buying: gold_buying,
                       total_price: total_price,
                       quantity: 0,
                       in_stock: false,
                       customer_id: customer_id,
                       user_id: user_id)
    # byebug
    if scrap.save && scrap1.save
      render json: { status: 'ok' }
    else
      render json: { status: 'fail' }
    end
  end
end
