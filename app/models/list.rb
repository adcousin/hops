class List < ApplicationRecord
  belongs_to :user
  has_many :contents, dependant: :destroy
end
