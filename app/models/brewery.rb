class Brewery < ApplicationRecord
  belongs_to :country
  has_many :beers
end
