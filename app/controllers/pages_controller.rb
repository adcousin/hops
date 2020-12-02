class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @beers.order('RANDOM()').limit(6)
  end
end
