FactoryBot.define do
  factory :customer do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    online { true }

    user
  end
end
