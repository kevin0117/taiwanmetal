FactoryBot.define do
  factory :sale do
    sale_date { Faker::Time.forward(days: 23, period: :morning) }
    gold_selling { Faker::Number.between(from: 5700, to: 6000) }
    gold_buying { Faker::Number.between(from: 5700, to: 6000) }
    exchange_weight { Faker::Number.decimal(l_digits: 2) }
    wastage_rate { 0.95 }
    net_weight { Faker::Number.decimal(l_digits: 2) }
    payment_method { 1 }
    service_fee { Faker::Number.between(from: 0, to: 2860) }
    weight { Faker::Number.decimal(l_digits: 2) }
    total_price { Faker::Number.between(from: 0, to: 100000) }

    product
    customer
    user
  end
end
