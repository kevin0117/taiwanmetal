FactoryBot.define do
  factory :product_list do
    name { Faker::Name.unique.name }
    code { Faker::Code.nric }
    description { Faker::Lorem.paragraph }
    online { false }

    user
  end
end
