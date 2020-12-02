class Brewery < ApplicationRecord
  belongs_to :country
  has_many :beers
  has_one_attached :photo
end
