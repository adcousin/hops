class List < ApplicationRecord
  belongs_to :user
  has_many :contents, dependent: :destroy
  has_many :beers, through: :contents

  validates_uniqueness_of :name, :scope => [:user_id], message: "The name  is already taken !"
end
