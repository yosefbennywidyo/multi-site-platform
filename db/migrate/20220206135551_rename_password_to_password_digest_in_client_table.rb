class RenamePasswordToPasswordDigestInClientTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :clients, :password, :password_digest
  end
end
