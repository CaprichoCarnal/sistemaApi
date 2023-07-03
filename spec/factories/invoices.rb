FactoryBot.define do
  factory :invoice do
    sale { nil }
    number { "MyString" }
    date { "2023-05-27" }
    total { "9.99" }
  end
end
