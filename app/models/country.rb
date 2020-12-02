class Country < ApplicationRecord
  has_many :breweries
  has_many :stores

  include PgSearch::Model
  multisearchable against: %i[name alcohol_strength ibu barcode]
end
