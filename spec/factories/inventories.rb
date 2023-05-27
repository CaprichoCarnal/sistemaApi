FactoryBot.define do
  factory :inventory do
    item { nil }
    category { "MyString" }
    lot { "MyString" }
    weight { 1.5 }
    expiration_date { "2023-05-26" }
  end
end
