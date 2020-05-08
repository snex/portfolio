FactoryBot.define do
  factory :quote do
    date { "2020-04-27" }
    price { "9.99" }
    financial_asset { nil }
  end
end
