class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :color, optional: true
  belongs_to :style, optional: true
  belongs_to :user, optional: true
  has_many :contents
  has_many :purchases
  has_many :reviews
end
