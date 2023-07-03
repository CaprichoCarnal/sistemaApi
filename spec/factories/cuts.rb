FactoryBot.define do
  factory :cut do
    raw_material { nil }
    name { "MyString" }
    lot { "MyString" }
    weight { 1.5 }
    matured { false }
    maturity_start_date { "2023-05-14" }
    maturity_end_date { "2023-05-14" }
    frozen { false }
    available_for_sale { false }
    prepared_by { "MyString" }
  end
end
