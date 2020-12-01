class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :address, :string
    add_column :users, :is_admin, :boolean
  end
end
