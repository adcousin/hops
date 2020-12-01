class StoresController < ApplicationController
  before_action :set_stores, only: %i[show destroy edit update]

  def index
    @stores = Store.all
  end

  def show
  end

  def new
    @store = Store.new
  end

  def create
    @store.new(store_params)
    # TODO : Geocode when saving
    # how to get country?

    if @store.save
      redirect_to store_path(@store), notice: 'Store successfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @store.update(store_params)
    redirect_to store_path(@store), notice: 'Store successfully updated'
  end

  private

  def store_params
    params.require(:store).permit(:name, :address)
  end

  def set_stores
    @store = Store.find(params[:id])
  end
end
