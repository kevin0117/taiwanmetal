FactoryBot.define do
  factory :scrap do
    collected_date {Faker::Time.forward(days: 23, period: :morning) }
    title { Faker::Commerce.product_name }
    gross_weight { Faker::Number.decimal(l_digits: 2) }
    wastage_rate { 0.95 }
    net_weight { Faker::Number.decimal(l_digits: 2) }
    gold_buying { Faker::Number.between(from: 5700, to: 6000) }
    total_price { Faker::Number.between(from: 5700, to: 6000) }
    in_stock { false }
    code { Faker::Code.nric }
    deleted_at { "2020-06-06 23:44:26" }
    
    customer
    user
  end
end
