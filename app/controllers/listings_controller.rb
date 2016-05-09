class ListingsController < ApplicationController
  
  def index
  end

  def new
  	@listing = listing_from_params
  	render template: "users/listings/new"
  end

  def create
  	@listing = listing_from_params

  	if @listing.save
  		redirect_to show_listing_path(id: @listing.id)
  	else
  		render template: "users/listings/new"
  	end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
