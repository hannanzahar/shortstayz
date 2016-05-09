class ListingsController < ApplicationController

	def index
		@listing = Listing.all
		@user = current_user
	end

	def new
		@listing = Listing.new
	end


  # def create
  # 	@listing = Listing.new(user_id: current_user.id)

  # 	if @listing.save
  # 		redirect_to show_listing_path(id: @listing.id)
  # 	else
  # 		render template: "users/listings/new"
  # 	end
  # end

	def create
		# byebug
		@listing = current_user.listings.new(listing_params)
		@listing.save
		redirect_to listing_path(@listing)
	end


	def show
		@listing = Listing.find(params[:id])
	end

	def edit

	end

	def update
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

# private
# 	def listing_params

# 	end

# end


	private

	 def listing_params
	   params.require(:listing).permit(:name, :description, :country, :state, :city, :address, :property_type, :room_type, :num_people, :num_bedrooms, :num_beds, :num_bathrooms)
	 end

end