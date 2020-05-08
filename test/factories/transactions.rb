FactoryBot.define do
  factory :transaction do
    date { "2020-04-27" }
    quantity { "" }
    price_paid { "" }
    investment { false }
    financial_asset { nil }
  end
end
