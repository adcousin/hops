class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @beers = Beer.order('RANDOM()').includes(:brewery, :style, :color, brewery: [:country]).limit(6)
  end

  def uikit
  end

  def search
  end

  def about
  end

  def contact
  end
end
