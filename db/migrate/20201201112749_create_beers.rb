class CreateBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.references :brewery, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.references :style, null: false, foreign_key: true
      t.text :description
      t.float :alcohol_strenght
      t.integer :ibu
      t.bigint :barcode
      t.boolean :is_validated
      t.references :user, null: false, foreign_key: true
      t.text :decline_reason

      t.timestamps
    end
  end
end
