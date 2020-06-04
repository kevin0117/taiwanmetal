FactoryBot.define do
  factory :vendor do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    online { false }
  end
end

# t.string "name"
# t.text "description"
# t.boolean "online", default: true
