class AddUserPasswordFields < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :password_salt, :string
    add_column :users, :password_hash, :string
  end
end
