class Style < ApplicationRecord
  has_many :beers

  include PgSearch::Model
  multisearchable against: %i[name]
end
