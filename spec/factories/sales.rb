FactoryBot.define do
  factory :sale do
    customer { nil }
    date { "2023-05-27" }
    total { "9.99" }
  end
end
