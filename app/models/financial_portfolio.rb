class FinancialPortfolio
  attr_reader :financial_assets

  def initialize
    @financial_assets = FinancialAsset.all
  end

  def total_invested
    @total_invested ||= @financial_assets.
      joins(:transactions).
      where(transactions: { investment: true }).sum('price_paid * quantity')
  end

  def total_value
    @total_value ||= @financial_assets.
      joins(:transactions).
      sum('price_paid * quantity')
  end

  def profit_loss
    @profit_loss ||= total_value - total_invested
  end

  def pct_profit_loss
    @pct_profit_loss ||= 100 * (profit_loss / total_invested)
  end

  def investment_data
    Quote.
      joins(
        'left outer join transactions on quotes.date = transactions.date
                                     and quotes.financial_asset_id = transactions.financial_asset_id'
      ).
      order('quotes.date').
      pluck(Arel.sql('case transactions.investment
               when true then price_paid
               else null
            end'))
  end

  def dividend_data
    Quote.
      joins(
        'left outer join transactions on quotes.date = transactions.date
                                     and quotes.financial_asset_id = transactions.financial_asset_id'
      ).
      order('quotes.date').
      pluck(Arel.sql('case transactions.investment
               when false then price_paid
               else null
            end'))
  end

  def datapoints_no_dividends
    []
  end

  def datapoints_with_dividends
    []
  end
end
