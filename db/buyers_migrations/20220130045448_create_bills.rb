class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.string :description
      #t.references :client, null: false, foreign_key: true
      t.bigint :transaction_id, null: false
      t.string :number, null: false
      t.integer :total, null: false
      t.string :type # pending / paid
      t.index [:transaction_id]

      t.timestamps
    end
  end
end
