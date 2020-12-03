class SearchesController < ApplicationController
  def index
    @results = PgSearch.multisearch(params[:query])
  end
end
