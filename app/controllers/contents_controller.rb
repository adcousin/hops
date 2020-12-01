class ContentsController < ApplicationController
  def new
    @content = Content.new
  end

  def create
    # How to get beer?
    @content = Content.new
    @list = List.find(params[:list_id])
    @content.list = @list
  end

  def destroy
    # Need help to understand what to destroy in this
    @content = Content.find(params[:id])
    @list = List.find(params[:list_id])
    @content.destroy

    redirect_to list_path(@list)
  end
end
