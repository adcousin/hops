class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_beers, only: %i[show destroy edit update validate! decline!]

  def index
    @beers = Beer.where(validated: true)
  end

  def show
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(beers_params)
    @beer.user = current_user
    @beer.is_validated = false

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
    params.require(:beer).permit(:name, :description, :alcohol_strength, :ibu, :barcode, :brewery_id, :color_id, :style_id)
  end

  def set_beers
    @beer = Beer.find(params[:id])
  end
end
