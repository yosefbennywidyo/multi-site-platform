class AddParentIdToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :parent_id, :bigint
  end
end
