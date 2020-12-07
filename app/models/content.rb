class Content < ApplicationRecord
  belongs_to :list
  belongs_to :beer

  validates_uniqueness_of :beer_id, :scope => [:list_id], message: "The beer  is already in the list !"
end
