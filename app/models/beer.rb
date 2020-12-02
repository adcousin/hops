class Beer < ApplicationRecord
  belongs_to :brewery
  belongs_to :color
  belongs_to :style
  belongs_to :user
  has_many :contents
  has_many :purchases
  has_many :reviews
  include PgSearch::Model

  pg_search_scope :global_search,
    against: %i[name alcohol_strength ibu],
    associated_against: {
      brewery: %i[name address]
    },
    using: {
      tsearch: { prefix: true }
    }
end
