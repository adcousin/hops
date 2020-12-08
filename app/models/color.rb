class Color < ApplicationRecord
  has_many :beers, dependent: :destroy
  COLORS = %i[Other White Blond Black Ruby Amber]
end
