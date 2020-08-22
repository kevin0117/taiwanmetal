FactoryBot.define do
  factory :commodity do
    weight { "9.99" }
    unit_price { "9.99" }
    total_price { "9.99" }
    status { "MyString" }
    action { 1 }
    user { nil }
  end
end
