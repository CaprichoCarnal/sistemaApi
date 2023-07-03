FactoryBot.define do
  factory :supply do
    supplier { nil }
    lot { "MyString" }
    name { "MyString" }
    quantity { 1 }
    weight { 1.5 }
  end
end
