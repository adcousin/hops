class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :color
  belongs_to :style
  belongs_to :user
end
