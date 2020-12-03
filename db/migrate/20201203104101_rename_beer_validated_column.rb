class RenameBeerValidatedColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :beers, :is_validated, :validated
  end
end
