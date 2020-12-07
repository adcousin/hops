class BreweriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_brewery, only: %i[show edit update destroy]

  def index
    @breweries = Brewery.all
  end

  def show
    if @brewery.geocoded?
      @markers = {
        lat: @brewery.latitude,
        lng: @brewery.longitude
      }
    else
      @markers = {
        lat: 50.631198343768695,
        lng: 3.054824203881607
      }
    end

    count_white_list
    count_black_list
    count_wish_list
    count_custom_list
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

  def count_white_list
    @white_count = 0
    @brewery.beers.each do |beer|
      single_white_count = List.joins(:contents).where("name = 'Whitelist' AND beer_id = ?", beer.id).count
      @white_count += single_white_count
    end
    return @white_count
  end

  def count_black_list
    @black_count = 0
    @brewery.beers.each do |beer|
      single_black_count = List.joins(:contents).where("name = 'Blacklist' AND beer_id = ?", beer.id).count
      @black_count += single_black_count
    end
    return @black_count
  end

  def count_wish_list
    @wish_count = 0
    @brewery.beers.each do |beer|
      single_wish_count = List.joins(:contents).where("name = 'Wishlist' AND beer_id = ?", beer.id).count
      @wish_count += single_wish_count
    end
    return @wish_count
  end

  def count_custom_list
    @custom_count = 0
    @brewery.beers.each do |beer|
      single_list_count = List.joins(:contents).where("name NOT IN ('Whitelist', 'Blacklist', 'Wishlist') AND beer_id = ?", beer.id).count
      @custom_count += single_list_count
    end
    return @custom_count
  end
end
