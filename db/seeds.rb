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
Color.create(name: "Other")
# Create dummy style
Style.create(name: "Other")

# split addresses in 3 parts
ZIP_REG = /[FDB]-\w+/
UK_ZIP_REG =/[A-Z0-9]{2,4} [A-Z0-9]{3}$/

def uk_script(brewery)
  if brewery.address
    addr = brewery.address
    zipcode = addr.slice!(UK_ZIP_REG)

    zip_sep = addr.rindex(",")
    if zip_sep
      address = addr[0..zip_sep - 1]
      city = addr[zip_sep + 1..-1].strip
    else
      address = ""
      city = addr.strip
    end

    brewery.street = address
    brewery.zipcode = zipcode
    brewery.city = city

    brewery.save
  end
end

def others_script(brewery)
  if brewery.address
    splitted = brewery.address.rpartition(ZIP_REG)
    brewery.street = splitted[0].delete_suffix(", ")
    brewery.zipcode = splitted[1]
    brewery.city = splitted[2].strip
    brewery.save
  end
end

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

    # split the address
    file_name == "UK" ? uk_script(new_brewery) : others_script(new_brewery)

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
create_breweries("FR", "France")
p "Create Belgian breweries"
create_breweries("BE", "Belgium")
p "Create English breweries"
create_breweries("UK", "United Kingdom")
p "Create German breweries"
create_breweries("DE", "Germany")

# Create colors
p "Create colors"
%w[White Blond Black Ruby Amber].each do |color|
  Color.create(name: color)
end

# Create styles
p "Create styles"
%w[Ale Lager Pilsener IPA Stout Sour Wheat Dubbel Lambic Triple Quadruple Wine Bitter].each do |style|
  Style.create(name: style)
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

# # Create random list's contents and reviews
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

# For some beers, populate color/style/photo
beers = [
    { beer_name: "Leffe Ruby", color_name: "Ruby", style_name: "IPA", photo_key: "2mghes6q5obg8ctrksmuzkwoyx8d" },
    { beer_name: "Leffe Tripel", color_name: "Blond", style_name: "tdb", photo_key: "jco9dpckxcb1bdcaky92i9e940jy" },
    { beer_name: "Leffe Blonde\/Blond", color_name: "Blond", style_name: "tdb", photo_key: "wxkmnryjinaxgpus3mvyhelxntdd" },
    { beer_name: "Leffe Brune\/Bruin", color_name: "Black", style_name: "tdb", photo_key: "m930fcrxxc78sfp6uox7k8basrm9" },
    { beer_name: "Leffe Radieuse", color_name: "Ruby", style_name: "tdb", photo_key: "xbefdk3d8gauhn3v6smzfrjpoi6a" },
    { beer_name: "Leffe Rituel 9°", color_name: "Blond", style_name: "tdb", photo_key: "aoeg8p4499c2mwvh7iyoagtfq4h8" },
    { beer_name: "Orval", color_name: "Blond", style_name: "tdb", photo_key: "sjxg39ew99kpzvoyqami8gkwf3ib" },
    { beer_name: "33 Export", color_name: "Blond", style_name: "tdb", photo_key: "fqn8adtiemw8l3h7a2xoidcqex6b" },
    { beer_name: "Guinness", color_name: "Black", style_name: "Stout", photo_key: "dimstmzbiw5rt6v9r5sbl4tqqqcv" },
    { beer_name: "Bière des Ours", color_name: "Blond", style_name: "tdb", photo_key: "7u21crfelwkbf9byfizybrxuyrra" },
    { beer_name: "Wychwood Hobgoblin Ruby", color_name: "Ruby", style_name: "Lambic", photo_key: "ohr4yqrtbbukwmrd2zcnwy7z9j52" },
    { beer_name: "Dark Ruby Ale", color_name: "Ruby", style_name: "Ale", photo_key: "b09jhn8fffo7gxhjb4pn1roma4oa" }
]
URL = "https://res.cloudinary.com/dmzqd01xs/image/upload/"

p "Seed details for some beers"
beers.each do |beer|
  p beer[:beer_name]
  b = Beer.find_by(name: beer[:beer_name])
  c = Color.find_by(name: beer[:color_name]) || Color.first
  s = Style.find_by(name: beer[:style_name]) || Style.first

  b.color = c
  b.style = s
  b.photo.attach(io: open("#{URL}#{beer[:photo_key]}"), filename: "#{beer[:beer_name]}.jpg")
  b.save
end

# THIS HAS NOT BEEN TESTED. DO NOT UNCOMMENT.
# p "Update random colors and styles for all beers"
# # Memo pour updater le jeu de données avec des trucs randoms
# a = Beer.all
# a.each { |x| x.update(color: Color.all.sample) }
# a.each { |x| x.update(style: Style.all.sample) }
# a.each { |x| x.update(ibu: Random.new.rand(1..100)) }
# a.each { |x| x.update(alcohol_strength: Random.new.rand(1.5..13.2).round(1)) }
