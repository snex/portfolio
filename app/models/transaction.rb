class Transaction < ApplicationRecord
  belongs_to :financial_asset

  def value
    price_paid * quantity
  end

  def current_value
    financial_asset.current_price * quantity
  end

  def profit_loss
    current_value - value
  end

  def pct_profit_loss
    100 * (current_value - value) / value
  end
end
