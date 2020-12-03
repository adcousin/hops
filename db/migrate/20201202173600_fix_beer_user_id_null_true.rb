class FixBeerUserIdNullTrue < ActiveRecord::Migration[6.0]
  def change
    change_column_null :beers, :user_id, true
  end
end
