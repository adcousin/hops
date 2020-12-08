class Style < ApplicationRecord
  has_many :beers, dependent: :destroy
  STYLES = %i[Other Ale Lager Pilsener IPA Stout Sour Wheat Dubbel Lambic Triple Quadruple Wine Bitter].freeze
end
