class BreweriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_brewery, only: %i[show edit update destroy]

  def index
    @breweries = Brewery.all

    # Geocoding markers
    @markers = @breweries.geocoded.map do |brewery|
      {
        lat: brewery.latitude,
        lng: brewery.longitude
      }
    end
  end

  def show
  end

  def new
    @brewery = Brewery.new
    @countries = Country.all
  end

  def create
    @brewery = Brewery.new(brewery_params)
    @brewery.address = "#{params[:brewery][:street]} #{params[:brewery][:zipcode]} #{params[:brewery][:city]}"
    @brewery.country = Country.find(params[:brewery][:country_id])

    if @brewery.save
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
    params.require(:brewery).permit(:name, :street, :zipcode, :city, :country_id, :photo)
  end

  def set_brewery
    @brewery = Brewery.find(params[:id])
  end
end
