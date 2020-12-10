class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_beers, only: %i[show destroy edit update validate! decline!]

  def index
    @beers = Beer.where(:validated == true || current_user == :user_id)
                 .includes(:brewery, :color, :style)
                 .order(:name)
  end

  def show
    # Initialize content to enable content create via action buttons
    @content = Content.new

    # Get the non-deletable lists of current_user
    @whitelist = List.where(user_id: current_user.id, name: 'Whitelist').first
    @blacklist = List.where(user_id: current_user.id, name: 'Blacklist').first
    @wishlist = List.where(user_id: current_user.id, name: 'Wishlist').first
    @user_core_lists = [@whitelist, @blacklist, @wishlist]

    # Get the active non-deletable list (if any)
    @active_core_list = @user_core_lists.reject { |list| @beer.contents.where(list_id: list.id).empty? }.first
    unless @active_core_list.nil?
      @active_core_content = @active_core_list.contents.where(beer_id: @beer.id, list_id: @active_core_list.id).take
    end

    # Display review if it exists, create empty review otherwise
    @beer_user_review = Review.where(beer_id: @beer.id, user_id: current_user.id).first
    if @beer_user_review
      @review = @beer_user_review
    else
      @review = Review.new
    end

    # WIP : Automate tag creation if nil?
    beer_tags = %i[alcohol_strength ibu]
    beer_attr = %i[brewery color style]

    # Count beers in each list
    @white_count = List.joins(:contents).where("name = 'Whitelist' AND beer_id = ?", @beer.id).count
    @black_count = List.joins(:contents).where("name = 'Blacklist' AND beer_id = ?", @beer.id).count
    @wish_count = List.joins(:contents).where("name = 'Wishlist' AND beer_id = ?", @beer.id).count
    @list_count = List.joins(:contents).where("name NOT IN ('Whitelist', 'Blacklist', 'Wishlist') AND beer_id = ?", @beer.id).count

    # beer proposals based on the users whitelists
    sql = %{with users_list as (select u.id user_ref
                               from   users u
                                     ,lists l
                                     ,contents c
                               where  u.id = l.user_id
                                 and  l.id = c.list_id
                                 and  c.beer_id = #{@beer.id}
                                 and  u.id != #{current_user.id}
                                 and  l.name = 'Whitelist')
           select b.id
           from   beers b
                 ,contents c
                 ,lists l
                 ,users_list ul
           where  b.id = c.beer_id
             and  c.list_id = l.id
             and  l.user_id = ul.user_ref
             and  l.name = 'Whitelist'
             and  b.id != #{@beer.id}
           group by b.name, b.id
           order by count(c.id) desc, b.name
           limit 4}

    @suggestions_id = ActiveRecord::Base.connection.exec_query(sql)
    @beer_suggestions = []
    @suggestions_id.each { |sugg| @beer_suggestions << Beer.find(sugg["id"]) }
  end

  def new
    @beer = Beer.new
    @beer.build_brewery
    @action = "Add"
  end

  def create
    @beer = Beer.new(beers_params)
    if beers_params[:brewery_id].nil? || beers_params[:brewery_id] == ''
      @brewery = Brewery.new(beers_params[:brewery_attributes])
      @brewery.address = "#{beers_params[:brewery_attributes][:street]} #{beers_params[:brewery_attributes][:zipcode]} #{beers_params[:brewery_attributes][:city].capitalize}"
      @brewery.save
      @beer.brewery = @brewery
    else
      @beer.brewery_id = beers_params[:brewery_id]
    end
    @beer.user = current_user
    @beer.validated = false unless current_user.admin
    if @beer.save
      redirect_to beer_path(@beer), notice: "#{@beer.name} successfully created"
    else
      @action = "Add"
      render :new
    end
  end

  def edit
    @action = "Edit"
  end

  def update
    if @beer.update(beers_params)
      redirect_to beer_path(@beer), notice: "#{@beer.name} successfully updated"
    else
      @action = "Edit"
      render :edit
    end
  end

  def destroy
    beer_name = @beer.name
    @beer.destroy
    redirect_to root_path, alert: "#{beer_name} successfully deleted"
  end

  def validation
    @pending_validations = Beer.where(validated: false)
  end

  def validate
    @beer.validated = true
    @beer.save
    redirect_to beer_path(@beer), notice: 'Beer sucessfully validated'
  end

  def decline
    @beer.validated = false
    @beer.save
    redirect_to beer_path(@beer), notice: 'Beer sucessfully declined'
  end

  def scan_barcode
  end

  def read_barcode
    if (@beer = Beer.find_by(barcode: params[:barcode]))
      redirect_to beer_path(@beer)
    elsif find_beer(params[:barcode])
      redirect_to new_beer_path(name: @api_answer['product']['product_name'],
                                barcode: params[:barcode],
                                alcohol_strength: @api_answer['product']['nutriments']['alcohol_value'])
      flash[:alert] = 'Have a look at what we found'
    else
      flash[:alert] = 'Your Beer was not found by our best algorithms, please enter it manually'
      redirect_to new_beer_path(barcode: params[:barcode])
    end
  end

  private

  def beers_params
    params.require(:beer).permit(:name, :description, :alcohol_strength, :ibu, :barcode, :brewery_id, :color_id, :style_id, :photo, brewery_attributes: [:name, :street, :zipcode, :city, :country_id])
  end


  def set_beers
    @beer = Beer.find(params[:id])
  end

  def request_api(url)
    connexion = Excon.new(
      url
    )
    connexion = connexion.get
    @api_answer = JSON.parse(connexion.body)
    return nil if @api_answer['status'].zero?

    return @api_answer
  end

  def find_beer(barcode)
    request_api(
      "https://world.openfoodfacts.org/api/v0/product/#{barcode}.json"
    )
  end
end
