class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rate
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :beer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
