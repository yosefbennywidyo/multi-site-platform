class CreateProductDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :product_details do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.integer :price
      t.string :type # purchase / release

      t.timestamps
    end
  end
end
