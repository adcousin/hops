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

  validates :name, :brewery_id, :color_id, :style_id, :alcohol_strength, presence: true
  validates :alcohol_strength, numericality: { :greater_than_or_equal_to => 0 }
  validates :ibu, numericality: { only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150 }, allow_nil: true
  before_save :capitalize

  include PgSearch::Model
  multisearchable against: %i[name alcohol_strength ibu]

  private

  def capitalize
    self.name = titleize(self.name)
    self.description.capitalize!
  end

  def titleize(str)
    str.split.map { |word| word.capitalize }.join(" ")
  end
end
