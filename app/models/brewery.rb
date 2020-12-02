class Brewery < ApplicationRecord
  belongs_to :country
  has_many :beers

  include PgSearch::Model
  multisearchable against: %i[name address]
end
