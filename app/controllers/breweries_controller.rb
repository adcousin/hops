class BreweriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_brewery, only: %i[show edit update destroy]

  def index
    @breweries = Brewery.all
  end

  def show
  end

  def new
    @brewery = Brewery.new
  end

  def create
    @brewery = Brewery.new(brewery_params)

    # how to get country?
    # need to geocode on save

    if @bewery.save
      redirect_to brewery_path(@brewery), notice: 'Brewery sucessfully created'
    else
      render :new
    end
  end

  def destroy
    @brewery.destroy
    redirect_to breweries_path, notice: 'Brewery sucessfully deleted'
  end

  private

  def brewery_params
    params.require(:brewery).permit(:name, :address, :photo)
  end

  def set_brewery
    @brewery = Brewery.find(params[:id])
  end
end
