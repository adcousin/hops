class ContentsController < ApplicationController
  def new
    @content = Content.new
  end

  def create
    # Need help
    @content = Content.new
    @list = List.find(params[:list_id])
    @content.list = @list
  end

  def destroy
    # Need Help
    @content = Content.find(params[:id])
    @list = List.find(params[:list_id])
    @content.destroy

    redirect_to list_path(@list)
  end
end
