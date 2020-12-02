class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :color
  belongs_to :style
  belongs_to :user
  has_many :contents
  has_many :purchases
  has_many :reviews

  include PgSearch::Model
  multisearchable against: %i[name alcohol_strength ibu barcode]
end
