class Color < ApplicationRecord
  has_many :beers, dependent: :destroy
end
