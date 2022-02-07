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

ActiveRecord::Schema.define(version: 2022_02_07_075237) do

  create_table "clients", charset: "utf8mb4", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "email"
    t.string "type"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products_shopping_carts", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "shopping_cart_id"
    t.integer "quantity"
    t.integer "price"
    t.integer "discount"
    t.index ["product_id"], name: "index_products_shopping_carts_on_product_id"
    t.index ["shopping_cart_id"], name: "index_products_shopping_carts_on_shopping_cart_id"
  end

  create_table "shopping_carts", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "client_id"
    t.string "transaction_id"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_shopping_carts_on_client_id"
  end

  create_table "transactions", charset: "utf8mb4", force: :cascade do |t|
    t.string "type"
    t.bigint "product_id"
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
    t.integer "quantity"
    t.integer "price"
    t.string "bill_number"
    t.integer "discount"
    t.integer "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.index ["bill_number"], name: "index_transactions_on_bill_number"
    t.index ["buyer_id"], name: "index_transactions_on_buyer_id"
    t.index ["seller_id"], name: "index_transactions_on_seller_id"
  end

end
