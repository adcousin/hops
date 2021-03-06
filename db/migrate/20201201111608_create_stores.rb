class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
