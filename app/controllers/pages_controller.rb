class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @beers = Beer.order('RANDOM()').includes(:brewery, :style, brewery: [:country]).limit(6)
  end
end
