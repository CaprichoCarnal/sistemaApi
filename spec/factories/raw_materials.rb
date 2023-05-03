FactoryBot.define do
  factory :raw_material do
    Raw_material_purchase { nil }
    family { nil }
    supplier { nil }
    born_date { "2023-05-01" }
    born_in { "MyString" }
    raised_in { "MyString" }
    slaughter_date { "2023-05-01" }
    slaughtered_in { "MyString" }
    crotal { "MyString" }
    lot { "MyString" }
    weight { 1.5 }
    temperature { 1.5 }
    classification { "MyString" }
    available { "MyString" }
  end
end
