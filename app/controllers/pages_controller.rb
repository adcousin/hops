class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
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
