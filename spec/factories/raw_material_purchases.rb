FactoryBot.define do
  factory :raw_material_purchase do
    date_of_purchase { "MyString" }
    supplier { nil }
    invoice_code { "MyString" }
    item { "MyString" }
    family { nil }
    description { "MyString" }
    lot { "MyString" }
    quantity { 1 }
    price { 1 }
    discount { 1 }
    total { 1 }
    vat { 1 }
    status { "MyString" }
  end
end
