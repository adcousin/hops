class SearchesController < ApplicationController
  def index
    @results = PgSearch.multisearch(params[:query])
    # Get the content of current_user core list
    @whitelist = Beer.joins(:lists).where("lists.name = 'Whitelist' AND lists.user_id = ?", current_user.id)
    @blacklist = Beer.joins(:lists).where("lists.name = 'Blacklist' AND lists.user_id = ?", current_user.id)
    @wishlist = Beer.joins(:lists).where("lists.name = 'Wishlist' AND lists.user_id = ?", current_user.id)
    @custom_lists = Beer.joins(:lists).where("lists.name NOT IN ('Whitelist', 'Blacklist', 'Wishlist') AND lists.user_id = ?", current_user.id)

    # Initialize arrays to store beer_id of each core list
    # Inclusion of beer.id in the list displays the icon or not on the card-lg
    @blacklist_ids = []
    @whitelist_ids = []
    @wishlist_ids = []
    @customlists_ids = []
    @blacklist.each {|x| @blacklist_ids << x.id} if
    @whitelist.each {|x| @whitelist_ids << x.id}
    @wishlist.each {|x| @wishlist_ids << x.id}
    @custom_lists.each {|x| @customlists_ids << x.id}
  end
end
