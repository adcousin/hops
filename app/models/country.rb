class Country < ApplicationRecord
  has_many :breweries, dependent: :destroy
  has_many :stores, dependent: :destroy
end
