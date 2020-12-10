class Brewery < ApplicationRecord
  belongs_to :country
  has_many :beers, dependent: :destroy
  has_one_attached :photo

  validates :name, :street, :zipcode, :city, :country_id, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  multisearchable against: %i[name zipcode city]

  private

  def titleize(str)
    str.split.map { |word| word.capitalize }.join(" ")
  end
end
