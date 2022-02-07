class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :type # order / queue
      t.bigint :product_id
      t.bigint :buyer_id, null: false
      t.bigint :seller_id, null: false
      t.integer :quantity
      t.integer :price
      t.string :bill_number
      t.integer :discount
      t.integer :total
      t.index [:buyer_id]
      t.index [:seller_id]
      t.index [:bill_number]

      t.timestamps
    end
  end
end
