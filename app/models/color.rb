class Color < ApplicationRecord
  has_many :beers, dependent: :destroy

  include PgSearch::Model
  multisearchable against: %i[name]
end
