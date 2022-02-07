class AddParentIdToProductDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :product_details, :parent_id, :bigint
  end
end
