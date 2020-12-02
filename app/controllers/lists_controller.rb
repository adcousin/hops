class ListsController < ApplicationController
  before_action :set_lists, only: %i[show destroy]

  def index
    @lists = List.all # To replace with PundIt scope
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(lists_params)
    @list.deletable = true
    @list.user = current_user

    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def lists_params
    params.require(:list).permit(:name)
  end

  def set_lists
    @list = List.find(params[:id])
  end
end
