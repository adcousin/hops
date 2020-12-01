class BreweriesController < ApplicationController
  before_action :set_brewery, only: %i[show edit update destroy]
  def index
    @breweries = Brewery.all
  end

  def show
  end

  private

  def brewery_params
    params.require(:brewery).permit(:name, :address)
  end

  def set_brewery
    @brewery = Brewery.find(params[:id])
  end
end
