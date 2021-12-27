class IndexController < ApplicationController
  def index
    @portfolio = FinancialPortfolio.new
    @transactions = Transaction.order(:date)
    @investment_data = @portfolio.investment_data
    @dividend_data = @portfolio.dividend_data
    @datapoints_no_dividends = @portfolio.datapoints_no_dividends
    @datapoints_with_dividends = @portfolio.datapoints_with_dividends
  end
end
