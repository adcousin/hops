class FixAlcoholStrenghtName < ActiveRecord::Migration[6.0]
  def change
    rename_column :beers, :alcohol_strenght, :alcohol_strength
  end
end
