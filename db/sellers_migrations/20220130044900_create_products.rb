class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      #t.references :client, null: false, foreign_key: true
      t.bigint :seller_id, null: false
      t.index [:seller_id]

      t.timestamps
    end
  end
end
