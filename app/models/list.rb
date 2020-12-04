class List < ApplicationRecord
  belongs_to :user
  has_many :contents, dependent: :destroy
  has_many :beers, through: :contents
end
