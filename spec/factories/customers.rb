FactoryBot.define do
  factory :customer do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    online { false }
  end
end
