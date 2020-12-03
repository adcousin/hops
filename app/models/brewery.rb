class Brewery < ApplicationRecord
  belongs_to :country
  has_many :beers, dependent: :destroy
  has_one_attached :photo

  include PgSearch::Model
  multisearchable against: %i[name address]
end
