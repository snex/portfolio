class Quote < ApplicationRecord
  belongs_to :financial_asset

  def self.fetch_all
    transaction do
      FinancialAsset.all.each do |fa|
        Rails.logger.info "Fetching yesterday's quote for #{fa.ticker_symbol}..."

        quote = StockQuote::Stock.quote(fa.ticker_symbol.split(':').last)

        if quote.latest_time.to_date <= fa.last_close_date
          Rails.logger.info "No new data for #{fa.ticker_symbol}, skipping"
          next
        end

        Rails.logger.info "Fetched data for #{fa.ticker_symbol}, price = #{quote.latest_price}"
        Quote.create!(financial_asset: fa, date: quote.latest_time.to_date, price: quote.latest_price)
      end
    rescue => e
      Rails.logger.error "Failed to update quotes on #{Date.today}, reason: #{e}"
    end
  end
end
