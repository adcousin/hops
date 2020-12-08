class Brewery < ApplicationRecord
  belongs_to :country
  has_many :beers, dependent: :destroy
  has_one_attached :photo

  validates :name, :street, :zipcode, :city, :country_id, presence: true
  before_save :capitalize

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  multisearchable against: %i[name zipcode city]

  private

  def capitalize
    self.name = titleize(self.name)
    self.address = titleize(self.address)
    self.street = titleize(self.street)
    self.city = titleize(self.city)
  end

  def titleize(str)
    str.split.map { |word| word.capitalize }.join(" ")
  end
end
