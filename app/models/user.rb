class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists
  has_many :beers
  has_many :reviews

  after_create :generate_default_lists

  private

  def generate_default_lists
    lists = ["Whitelist", "Blacklist", "Wishlist"]

    lists.each do |list|
      new_list = List.new(name: list, deletable: false)
      new_list.user = self
      new_list.save
    end
  end
end
