FactoryBot.define do
  factory :refine_order do
    request_date { Faker::Time.forward(days: 23, period: :morning) }
    status { rand(0..3) }
    refine_fee { [9, 18].sample }
    result_weight { Faker::Number.decimal(l_digits: 2) }
    result_purity { Faker::Number.decimal(l_digits: 2) }
    recipient { Faker::Name.last_name }
    state { ["pending", "scheduling", "confirming", "closing"].sample }
    note { Faker::Lorem.paragraph }
  
    scrap
    user
  end
end
