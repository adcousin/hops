class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :deletable

      t.timestamps
    end
  end
end
