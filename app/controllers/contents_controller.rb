class ContentsController < ApplicationController
  def new
    @content = Content.new
  end

  def create
    # How to get beer?
    @content = Content.new
    @list = List.find(params[:list_id])
    @content.list = @list
    @content.beer_id = params[:beer_id]
    if @content.save
      redirect_to beer_path(params[:beer_id])
    else
      flash[:notice] = 'Something went wrong'
      redirect_to beer_path(params[:beer_id])
    end
  end

  def destroy
    # Need help to understand what to destroy in this
    @content = Content.find(params[:id])
    @list = List.find(params[:list_id])
    @content.destroy

    redirect_to list_path(@list)
  end
end
