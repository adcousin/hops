class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_beers, only: %i[show destroy edit update validate! decline!]

  def index
    @beers = Beer.where(:validated == true || current_user == :user_id)
                 .includes(:brewery, :color, :style)
                 .order(:name)
  end

  def show
    @beer_user_review = Review.where(beer_id: @beer.id, user_id: current_user.id).first
    if @beer_user_review
      @review = @beer_user_review
    else
      @review = Review.new
    end
    beer_tags = %i[alcohol_strength ibu] # WIP : Automate tag creation if nil?
    beer_attr = %i[brewery color style] # WIP : Automate tag creation if nil?
    @white_count = List.joins(:contents).where("name = 'Whitelist' AND beer_id = ?", @beer.id).count
    @black_count = List.joins(:contents).where("name = 'Blacklist' AND beer_id = ?", @beer.id).count
    @wish_count = List.joins(:contents).where("name = 'Wishlist' AND beer_id = ?", @beer.id).count
    @list_count = List.joins(:contents).where("name NOT IN ('Whitelist', 'Blacklist', 'Wishlist') AND beer_id = ?", @beer.id).count
    # @list_count = 0
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(beers_params)
    @beer.user = current_user
    @beer.validated = false

    if @beer.save
      redirect_to beer_path(@beer), notice: 'Beer successfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @beer.update(beers_params)
    redirect_to beer_path(@beer), notice: 'Beer successfully updated'
  end

  def destroy
    @beer.destroy
    redirect_to beers_path, notice: 'Beer successfully deleted'
  end

  def validation
    Beer.where(validated: false)
  end

  def validate
    @beer.is_validated = true
    @beer.save
    redirect_to beer_path(@beer), notice: 'Beer sucessfully validated'
  end

  def decline
    @beer.is_validated = false
    @beer.save
    redirect_to beer_path(@beer), notice: 'Beer sucessfully declined'
  end

  private

  def beers_params
    params.require(:beer).permit(:name, :description, :alcohol_strength, :ibu, :barcode, :brewery_id, :color_id, :style_id, :photo)
  end


  def set_beers
    @beer = Beer.find(params[:id])
  end
end
