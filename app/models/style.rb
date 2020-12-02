class Style < ApplicationRecord
  has_many :beers, dependent: :destroy
end
