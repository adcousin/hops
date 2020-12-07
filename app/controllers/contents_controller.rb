class ContentsController < ApplicationController
  def new
    @beer = Beer.find(params[:beer_id])
    @lists = List.where(user_id: current_user.id)
    @custom_lists = @lists.where("name NOT IN ('Whitelist', 'Blacklist', 'Wishlist')")
    @content = Content.new
  end

  def create
    @content = Content.new
    @user_core_lists = params[:user_core_lists]
    if params[:list_id].nil?
      @content.list_id = params[:content][:list]
      @content.beer_id = params[:beer_id]
    else
      if @user_core_lists.include?(params[:list_id])
        Content.where(beer_id: params[:beer_id], list_id: params[:list_id]).delete_all
      end
      @list = List.find(params[:list_id])
      @content.list = @list
      @content.beer_id = params[:beer_id]
    end
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
