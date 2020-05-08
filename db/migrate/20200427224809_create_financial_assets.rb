class CreateFinancialAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_assets do |t|
      t.string :ticker_symbol, null: false

      t.timestamps
    end
  end
end
