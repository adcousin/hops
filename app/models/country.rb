class Country < ApplicationRecord
  has_many :breweries, dependent: :destroy
  has_many :stores, dependent: :destroy

  include PgSearch::Model
  multisearchable against: %i[name alcohol_strength ibu barcode]
end
