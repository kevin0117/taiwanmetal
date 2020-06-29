FactoryBot.define do
  factory :price_board do
    price_date { Faker::Time.forward(days: 23, period: :morning) }
    gold_selling { Faker::Number.between(from: 6000, to: 6300) }
    gold_buying { Faker::Number.between(from: 5700, to: 6000) }
    platinum_selling { Faker::Number.between(from: 3800, to: 4500) }
    platinum_buying { Faker::Number.between(from: 3300, to: 5000) }
    wholesale_gold_selling { Faker::Number.between(from: 6000, to: 6300) }
    wholesale_gold_buying { Faker::Number.between(from: 600, to: 6300) }
    wholesale_platinum_selling { Faker::Number.between(from: 5600, to: 6280) }
    wholesale_platinum_buying { Faker::Number.between(from: 5600, to: 6280) }
    description { Faker::Lorem.paragraph }
    online { false }

    user
  end
end
