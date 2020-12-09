class BreweriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_brewery, only: %i[show edit update destroy]
  before_action :count_white_list, :count_black_list, :count_wish_list, :count_custom_list, :count_amber_beers,
                :count_black_beers, :count_blond_beers, :count_ruby_beers, :count_white_beers, :count_other_beers, only: %i[show]

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

    # Get the content of current_user core list
    @whitelist = Beer.joins(:lists).where("lists.name = 'Whitelist' AND lists.user_id = ?", current_user.id)
    @blacklist = Beer.joins(:lists).where("lists.name = 'Blacklist' AND lists.user_id = ?", current_user.id)
    @wishlist = Beer.joins(:lists).where("lists.name = 'Wishlist' AND lists.user_id = ?", current_user.id)
    @custom_lists = Beer.joins(:lists).where("lists.name NOT IN ('Whitelist', 'Blacklist', 'Wishlist') AND lists.user_id = ?", current_user.id)

    # Initialize arrays to store beer_id of each core list
    # Inclusion of beer.id in the list displays the icon or not on the card-lg
    @blacklist_ids = []
    @whitelist_ids = []
    @wishlist_ids = []
    @customlists_ids = []
    @blacklist.each {|x| @blacklist_ids << x.id} if
    @whitelist.each {|x| @whitelist_ids << x.id}
    @wishlist.each {|x| @wishlist_ids << x.id}
    @custom_lists.each {|x| @customlists_ids << x.id}
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
    @brewery = Brewery.includes(:beers, beers: [:color, { contents: [:list] }]).find(params[:id])
  end

  def count_white_list
    @whitelist_count = 0
    @brewery.beers.each do |beer|
      single_white_count = List.joins(:contents).where("name = 'Whitelist' AND beer_id = ?", beer.id).count
      @whitelist_count += single_white_count
    end
    return @whitelist_count
  end

  def count_black_list
    @blacklist_count = 0
    @brewery.beers.each do |beer|
      single_black_count = List.joins(:contents).where("name = 'Blacklist' AND beer_id = ?", beer.id).count
      @blacklist_count += single_black_count
    end
    return @blacklist_count
  end

  def count_wish_list
    @wishlist_count = 0
    @brewery.beers.each do |beer|
      single_wish_count = List.joins(:contents).where("name = 'Wishlist' AND beer_id = ?", beer.id).count
      @wishlist_count += single_wish_count
    end
    return @wishlist_count
  end

  def count_custom_list
    @customlist_count = 0
    @brewery.beers.each do |beer|
      single_list_count = List.joins(:contents).where("name NOT IN ('Whitelist', 'Blacklist', 'Wishlist') AND beer_id = ?", beer.id).count
      @customlist_count += single_list_count
    end
    return @customlist_count
  end

  def count_amber_beers
    @amber_count = 0
    @brewery.beers.each do |beer|
      @amber_count += 1 if beer.color.name == 'Amber'
    end
  end

  def count_ruby_beers
    @ruby_count = 0
    @brewery.beers.each do |beer|
      @ruby_count += 1 if beer.color.name == 'Ruby'
    end
  end

  def count_black_beers
    @black_count = 0
    @brewery.beers.each do |beer|
      @black_count += 1 if beer.color.name == 'Black'
    end
  end

  def count_blond_beers
    @blond_count = 0
    @brewery.beers.each do |beer|
      @blond_count += 1 if beer.color.name == 'Blond'
    end
  end

  def count_white_beers
    @white_count = 0
    @brewery.beers.each do |beer|
      @white_count += 1 if beer.color.name == 'White'
    end
  end

  def count_other_beers
    @other_count = 0
    @brewery.beers.each do |beer|
      @other_count += 1 if beer.color.name == 'Other'
    end
  end
end
