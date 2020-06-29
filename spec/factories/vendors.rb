FactoryBot.define do
  factory :vendor do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    online { false }

    user
  end
end

# t.string "name"
# t.text "description"
# t.boolean "online", default: true
