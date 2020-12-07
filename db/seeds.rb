# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

# clean all db tables
p "Clean tables..."
Content.delete_all
Review.delete_all
Purchase.delete_all
Beer.delete_all
Color.delete_all
Style.delete_all
Brewery.delete_all
Store.delete_all
Country.delete_all
List.delete_all
User.delete_all


# Insert countries
p "Create countries"
["France", "United Kingdom", "Belgium", "Germany"].each do |country|
  Country.create(name: country)
end

# Create dummy color
Color.create(name: "tdb")
# Create dummy style
Style.create(name: "tdb")

# Insert Breweries
def create_breweries(file_name, country_name)
  file = File.join(File.dirname(__FILE__), "./breweries#{file_name}.json")
  list = JSON.parse(File.read(file))
  country = Country.find_by(name: country_name)
  
  total_breweries = list["breweries"].count
  br = 0
  be = 0
  list["breweries"].each do |brewery|
    br_name = brewery["name"]
    br_address = brewery["address"]
    new_brewery = Brewery.new(name: br_name,
                              address: br_address,
                              country_id: country.id)
    br += 1 if new_brewery.save
    
    brewery["beers"].each do |beer|
      be_name = beer["name"]
      be_alcohol = beer["alcohol"].gsub("%", "") if beer["alcohol"]
      new_beer = Beer.new(name: be_name,
                          alcohol_strength: be_alcohol,
                          brewery_id: new_brewery.id,
                          validated: true)
      new_beer.color = Color.first
      new_beer.style = Style.first
      be += 1 if new_beer.save
    end
    printf("\rProgress: [%-20s]", "=" * ((br*100/total_breweries)/5))
  end
  puts
  p "#{br} breweries created (#{be} beers)"
end

p "Create French breweries"
create_breweries("FR", "French")
p "Create Belgian breweries"
create_breweries("BE", "Belgium")
p "Create English breweries"
create_breweries("UK", "United Kingdom")
p "Create German breweries"
create_breweries("DE", "Germany")

# Create colors
p "Create colors"
["White", "Blonde", "Black", "Ruby", "Amber"].each do |color|
  Color.create(name: color)
end

# Create users
p "Create users"
USERS_NAMES = ['julien', 'adrien', 'jp', 'stephane', 'admin']
USERS_NAMES.each do |username|
  User.create!(
    email: "#{username}@email.com",
    nickname: username,
    password: '123456',
    password_confirmation: '123456',
    admin: username == 'admin'
  )
end

# Create random list's contents and reviews
p "Create random lists contents and reviews"
User.all.each do |user|
  break if user.admin
  user.lists.each do |list|
    5.times do
      idx_beer = rand(Beer.first.id...Beer.last.id)
      cont = Content.new(beer_id: idx_beer)
      cont.list = list
      cont.save

      rev = Review.new(rate: rand(1..5), comment: "Bon", beer_id: idx_beer)
      rev.user = user
      rev.save
    end
  end
end
