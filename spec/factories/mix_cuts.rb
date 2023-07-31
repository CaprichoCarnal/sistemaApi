FactoryBot.define do
  factory :mix_cut do
    name { "MyString" }
    weight { 1 }
    lot { "MyString" }
    cut { nil }
    frozen { false }
    expiration_date { "2023-07-30" }
  end
end
