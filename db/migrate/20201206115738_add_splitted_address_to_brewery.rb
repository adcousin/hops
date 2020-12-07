class AddSplittedAddressToBrewery < ActiveRecord::Migration[6.0]
  def change
    add_column :breweries, :street, :string
    add_column :breweries, :zipcode, :string
    add_column :breweries, :city, :string
  end
end
