class ContentsController < ApplicationController
  def new
    @beer = Beer.find(params[:beer_id])
    @lists = List.where(user_id: current_user.id)
    @custom_lists = @lists.where("name NOT IN ('Whitelist', 'Blacklist', 'Wishlist')")
    @content = Content.new
  end

  def create
    # params contains 3 important keys
    # list_id = "1" from URL
    # beer_id = "5" & user_core_lists = ["1", "2", "3"] from additional param in post request (using beer#show)

    # Beer id is in params in beer#show and in params[:content] in list#show
    if params[:beer_id].nil?
      @beer = Beer.find(params[:content][:beer_id])
    else
      @beer = Beer.find(params[:beer_id])
    end

    # Get the lists of current_user
    @lists = List.where(user_id: current_user.id)
    @custom_lists = @lists.where("name NOT IN ('Whitelist', 'Blacklist', 'Wishlist')")

    # Initialize content
    @content = Content.new

    # Get important keys from param
    @user_core_lists = params[:user_core_lists]
    list_id = params[:list_id]
    beer_id = @beer.id

    # I add a beer to a list from content#new specific form
    if list_id.nil?
      @content.list_id = params[:content][:list]
      @content.beer_id = beer_id
      if @content.save
        redirect_to beer_path(params[:beer_id])
      else
        flash[:notice] = "Crappy error message : #{@content.errors.messages[:beer_id].first}. Beer name :  #{@beer.name} // List name #{List.find(@content.list_id).name}".html_safe
        render :new
      end
    # I add a beer from a list#show
    elsif ['Whitelist', 'Blacklist', 'Wishlist'].exclude?(List.find(list_id).name)
      @list = List.find(list_id)
      @content.list = @list
      @content.beer_id = beer_id
      if @content.save
        @content.save
        redirect_to list_path(@list)
      else
        flash[:notice] = "Something went wrong list#show : #{@content.errors.messages}"
        redirect_to list_path(@list)
      end
    # I add a beer to a core list from beer#show
    else
      # Purge all previous contents if we update a core list
      if @user_core_lists.include?(list_id)
        Content.where(beer_id: beer_id, list_id: @user_core_lists).delete_all
      end
      # Standard update of the content
      @list = List.find(list_id)
      @content.list = @list
      @content.beer_id = params[:beer_id]
      if @content.save
        @content.save
        redirect_to beer_path(params[:beer_id])
      else
        flash[:notice] = 'Something went wrong beer#show'
      end
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @list = List.find(params[:list_id])
    @content.destroy

    redirect_to lists_path
    # redirect_to list_path(@list)
  end
end
