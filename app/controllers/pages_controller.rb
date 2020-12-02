class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    Beer.order('RANDOM()').limit(6)
  end
end
