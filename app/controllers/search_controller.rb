class SearchController < ApplicationController
  def index
    @q = params[:query]
    @search = PgSearch.multisearch(params[:query]).reorder(id: :desc)
  end
end
