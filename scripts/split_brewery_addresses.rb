fr_breweries = Brewery.where(country_id: Country.find_by(name: "France"))
be_breweries = Brewery.where(country_id: Country.find_by(name: "Belgium"))
de_breweries = Brewery.where(country_id: Country.find_by(name: "Germany"))
uk_breweries = Brewery.where(country_id: Country.find_by(name: "United Kingdom"))

ZIP_REG = /[FDB]-\w+/
UK_ZIP_REG =/[A-Z0-9]{2,4} [A-Z0-9]{3}$/
LOG_FILE = File.new("scripts/split_addr_logs.txt", "a")

def split_addr(breweries, country)
  p "#{country} addresses"
  breweries.each do |brewery|
    if brewery.address
      splitted = brewery.address.rpartition(ZIP_REG)
      brewery.street = splitted[0].delete_suffix(", ")
      brewery.zipcode = splitted[1]
      brewery.city = splitted[2].strip
      brewery.save
    end
  end
end

split_addr(fr_breweries, "French")
split_addr(be_breweries, "Belgian")
split_addr(de_breweries, "German")

p "English addresses"
uk_breweries.each do |brewery|
  if brewery.address
    addr = "  #{brewery.address}"
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

p "#{Brewery.count} breweries, #{Brewery.where(city: nil).count} without city"
p "#{Brewery.select(:city).distinct.count} distinct cities"
