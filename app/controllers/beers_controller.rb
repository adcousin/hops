class BeersController < ApplicationController
  before_action :set_beers, only: %i[show destroy edit update validate!]

  def index
    @beers = Beer.where(:is_validated == true)
  end

  def show
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer.new(beers_params)
    @beer.user = current_user
    @beer.is_validated = nil # nil value = validation pending

    if @beer.save
      redirect_to beer_path(@beer)
    else
      render :new
    end
  end

  def validation
    @beers.where(:is_validated.nil?)
  end

  def validate!
    @beer.is_validated = true
    @beer.save
  end

  def decline!
    @beer.is_validated = false
    @beer.save
  end

  private

  def beers_params
    params.require(:beer).permit(:name, :description, :alcohol_strength, :ibu, :barcode)
  end

  def set_beers
    @beer = Beer.find(params[:id])
  end
end
