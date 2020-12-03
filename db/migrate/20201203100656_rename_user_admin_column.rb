class RenameUserAdminColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :is_admin, :admin
  end
end
