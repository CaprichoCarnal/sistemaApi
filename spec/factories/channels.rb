FactoryBot.define do
  factory :channel do
    family { nil }
    supplier { nil }
    born_date { "2023-04-21" }
    born_in { "MyString" }
    raised_in { "MyString" }
    slaughter_date { "2023-04-21" }
    slaughtered_in { "MyString" }
    crotal { "MyString" }
    lot { "MyString" }
    weight { 1.5 }
    temperature { 1.5 }
    classification { "MyString" }
    available { "MyString" }
  end
end
