class FinancialAsset < ApplicationRecord
  has_many :quotes
  has_many :transactions

  def first_investment_date
    transactions.order(:date).first.date
  end

  def current_price
    quotes.order(date: :desc).first.price
  end

  def last_close_date
    quotes.order(date: :desc).first.date
  end

  def total_quantity
    transactions.sum(:quantity)
  end

  def dividend_quantity
    transactions.where(investment: false).sum(:quantity)
  end

  def total_invested
    transactions.where(investment: true).sum('price_paid * quantity')
  end

  def total_value
    (total_quantity * current_price)
  end

  def profit_loss
    (total_value - transactions.where(investment: true).sum('price_paid * quantity'))
  end

  def pct_profit_loss
    100 * (profit_loss / total_invested)
  end

  def capital_gains
    total_value - total_invested - dividends
  end

  def dividends
    dividend_quantity * current_price
  end

  def cagr(start_date = first_investment_date, end_date = last_close_date)
    100 * CashFlowAnalysis::Calculator::Cagr.calculate(total_invested, total_value, (end_date - start_date) / 365)
  end

  def datapoints_no_dividends(start_date = first_investment_date, end_date = last_close_date)
    quotes.where('date between ? and ?', start_date, end_date).order(:date).pluck(:date, :price)
  end

  def datapoints_with_dividends(start_date = first_investment_date, end_date = last_close_date)
    sql = %{
      select
        quotes.date as date
        ,round(quotes.price + coalesce(sum(q.div_per_share) over (order by quotes.date),0),2) as close_plus_div

      FROM
        quotes
        inner join (
          SELECT
            quotes.financial_asset_id
            ,quotes.date as date
            ,coalesce(t2.div_payout,0) / coalesce(nullif((coalesce(sum(t1.quantity) over (order by quotes.date),0) - coalesce(t1.quantity,0)),0),1) as div_per_share

          FROM
            quotes
            left outer join transactions t1 on quotes.financial_asset_id = t1.financial_asset_id
                                           and quotes.date = t1.date
            left outer join (
              select
                date as date
                ,financial_asset_id as financial_asset_id
                ,coalesce(price_paid * quantity, 0) as div_payout
                ,coalesce(quantity, 0) as quantity
                ,sum(quantity) over (order by date) as cum_quantity
              from
                transactions
    	      where
                investment = false
              order by
                date
            ) as t2 on quotes.date = t2.date
                   and quotes.financial_asset_id = t2.financial_asset_id

          where quotes.financial_asset_id = #{id}
          ORDER BY
            quotes.date
        ) as q on q.date = quotes.date
	      and q.financial_asset_id = quotes.financial_asset_id

      where
        quotes.financial_asset_id = #{id}
        AND quotes.date between '#{start_date}' and '#{end_date}'

      order by
        quotes.date
    }
    self.class.connection.select_all(sql).rows.map { |row| [row.first.to_date, row.last.to_d] }
  end

  def investment_data
    self.quotes.joins('left outer join transactions on quotes.date = transactions.date and quotes.financial_asset_id = transactions.financial_asset_id').where(transactions: { investment: [true, nil] }).order('quotes.date').pluck(:price_paid)
  end

  def dividend_data
    self.quotes.joins('left outer join transactions on quotes.date = transactions.date and quotes.financial_asset_id = transactions.financial_asset_id').where(transactions: { investment: [false, nil] }).order('quotes.date').pluck(:price_paid)
  end
end
