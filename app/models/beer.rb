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

  accepts_nested_attributes_for :brewery

  validates :name, :brewery_id, :color_id, :style_id, :alcohol_strength, presence: true
  validates :alcohol_strength, numericality: { :greater_than_or_equal_to => 0 }
  validates :ibu, numericality: { only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 150 }, allow_nil: true

  include PgSearch::Model
  multisearchable against: %i[name alcohol_strength ibu]

  private

  def titleize(str)
    str.split.map { |word| word.capitalize }.join(" ")
  end
end
