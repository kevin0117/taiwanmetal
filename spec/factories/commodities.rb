FactoryBot.define do
  factory :commodity do
    weight { Faker::Number.decimal(l_digits: 2) }
    unit_price { Faker::Number.between(from: 5700, to: 6000) }
    total_price { weight.to_f * unit_price.to_f }
    status { ["open", "closed", "cancelled"].sample }
    action { rand(0..1) }
    user
  end
end
