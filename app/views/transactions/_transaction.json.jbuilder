json.extract! transaction, :id, :date, :quantity, :price_paid, :investment, :financial_asset_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
