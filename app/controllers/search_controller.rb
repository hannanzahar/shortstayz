class SearchController < ApplicationController
  def search
  	if params[:q].nil?
  		@listing = []
  	else
  		@listing = Listing.search(params[:q]).records
  	end
  end
end
