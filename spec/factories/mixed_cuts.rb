FactoryBot.define do
  factory :mixed_cut do
    mix_cut { nil }
    cut { nil }
    weight { 1 }
  end
end
