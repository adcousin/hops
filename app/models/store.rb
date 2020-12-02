class Store < ApplicationRecord
  belongs_to :country
  has_many :purchases
end
