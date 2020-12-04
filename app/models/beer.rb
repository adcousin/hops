class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :color, optional: true
  belongs_to :style, optional: true
  belongs_to :user, optional: true
  has_many :contents, dependent: :destroy
  has_many :lists, through: :contents
  has_many :purchases, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :photo

  include PgSearch::Model
  multisearchable against: %i[name alcohol_strength ibu]
end
