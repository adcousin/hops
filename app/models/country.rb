class Country < ApplicationRecord
	has_many :breweries
	has_many :stores
end
