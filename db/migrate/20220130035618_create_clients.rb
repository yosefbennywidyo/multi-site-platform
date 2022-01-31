class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :slug
      t.string :name
      t.string :email
      t.string :type # buyer / seller
      t.string :password

      t.timestamps
    end
  end
end
