class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.date       :date,            null: false
      t.decimal    :quantity,        null: false, scale: 3, precision: 20
      t.decimal    :price_paid,      null: false, scale: 2, precision: 20
      t.boolean    :investment,      null: false
      t.references :financial_asset, null: false, foreign_key: true

      t.timestamps
    end
  end
end
