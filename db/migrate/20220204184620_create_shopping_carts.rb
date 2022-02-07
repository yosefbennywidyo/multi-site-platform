class CreateShoppingCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_carts do |t|
      t.bigint :client_id
      t.string :transaction_id
      t.string :type # shopping / equeue
      t.index [:client_id]

      t.timestamps
    end
  end
end
