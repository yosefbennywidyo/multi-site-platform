# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_30_055635) do

  create_table "clients", charset: "utf8mb4", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "email"
    t.string "type"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", charset: "utf8mb4", force: :cascade do |t|
    t.string "type"
    t.bigint "product_id", null: false
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
    t.integer "quantity"
    t.integer "price"
    t.string "bill_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bill_number"], name: "index_transactions_on_bill_number"
    t.index ["buyer_id"], name: "index_transactions_on_buyer_id"
    t.index ["product_id"], name: "index_transactions_on_product_id"
    t.index ["seller_id"], name: "index_transactions_on_seller_id"
  end

end
