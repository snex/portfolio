# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_27_225208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "financial_assets", force: :cascade do |t|
    t.string "ticker_symbol", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "price", precision: 20, scale: 2, null: false
    t.bigint "financial_asset_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["financial_asset_id"], name: "index_quotes_on_financial_asset_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "quantity", precision: 20, scale: 3, null: false
    t.decimal "price_paid", precision: 20, scale: 2, null: false
    t.boolean "investment", null: false
    t.bigint "financial_asset_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["financial_asset_id"], name: "index_transactions_on_financial_asset_id"
  end

  add_foreign_key "quotes", "financial_assets"
  add_foreign_key "transactions", "financial_assets"
end
