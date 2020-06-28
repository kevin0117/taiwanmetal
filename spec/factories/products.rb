FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    weight { Faker::Number.decimal(l_digits: 2) }
    cost { Faker::Number.between(from: 0, to: 980) }
    service_fee { Faker::Number.between(from: 150, to: 1280) }
    barcode { Faker::Code.nric }
    on_sell { false }
    code { Faker::Code.nric }
    deleted_at { "2020-06-05 13:16:54" }
    quantity { Faker::Number.between(from: 0, to: 100) }

    vendor
    price_board
    product_list
    user
  end
end
