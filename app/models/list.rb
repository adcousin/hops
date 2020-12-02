class List < ApplicationRecord
  belongs_to :user
  has_many :contents, dependent: :destroy
end
