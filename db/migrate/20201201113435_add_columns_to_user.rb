class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :user, :nickname, :string
    add_column :user, :address, :string
    add_column :user, :is_admin, :boolean
  end
end
