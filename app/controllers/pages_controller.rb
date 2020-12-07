class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @beers = Beer.includes(:brewery, :style, :color, brewery: [:country]).order(updated_at: :desc).limit(6)
  end

  def uikit
    @beer = Beer.order('RANDOM()').includes(:brewery, :style, :color, brewery: [:country]).limit(1)
  end

  def search
  end

  def about
  end

  def contact
  end

  def faq
  end
end
