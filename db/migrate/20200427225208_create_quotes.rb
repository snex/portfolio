class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.date       :date,            null: false
      t.decimal    :price,           null: false, scale: 2, precision: 20
      t.references :financial_asset, null: false, foreign_key: true

      t.timestamps
    end
  end
end
