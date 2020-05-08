class FinancialPortfolio
  def initialize
  end

  def total_invested
    financial_assets.map(&:total_invested).sum
  end

  def total_value
    financial_assets.map(&:total_value).sum
  end

  def profit_loss
    financial_assets.map(&:profit_loss).sum
  end

  def pct_profit_loss
    (profit_loss / total_invested)
  end

  def capital_gains
    financial_assets.map(&:capital_gains).sum
  end

  def dividends
    financial_assets.map(&:dividends).sum
  end

  def cagr
    d1 = Transaction.order(:date).first.date
    d2 = Quote.order(date: :desc).first.date

    CashFlowAnalysis::Calculator::Cagr.calculate(total_invested, total_value, (d2 - d1) / 365)
  end

  private

  def financial_assets
    FinancialAsset.all
  end
end
