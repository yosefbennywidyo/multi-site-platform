class CreateProductsShoppingCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :products_shopping_carts do |t|
      t.bigint :product_id
      t.bigint :shopping_cart_id
      t.integer :quantity
      t.integer :price
      t.integer :discount
    end

    add_index :products_shopping_carts, :product_id
    add_index :products_shopping_carts, :shopping_cart_id
  end
end
