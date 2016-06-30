class ListingsController < ApplicationController

	def index
		@user = current_user
		if params[:tag] && params[:search].present?
			@listing = Listing.tagged_with(params[:tag])
			@listing = Listing.near(params[:search], 50, :order => :distance)
		else
			@listing = Listing.all
		end
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
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			flash[:success] = "Created successfully!"
		else
			flash[:warning] = @listing.errors
		end
		redirect_to my_profile_path
	end


	def show
		@listing = Listing.find(params[:id])
		@user = current_user
		@reserve = @listing.reservations.new
	end

	def edit
		# byebug
		@listing = Listing.find(params[:id])

	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(new_params)
			if @listing.save
				redirect_to listing_path
			else
				flash[:warning] = "Not updated, please update again."
				render :edit
			end
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
	   params.require(:listing).permit(
	   	:name, :description, :country,
	   	:state, :city, :address, :property_type,
	   	:room_type, :num_people, :num_bedrooms, 
	   	:num_beds, :num_bathrooms, :price, 
	   	:tag_list, {images: []}, :reservations)

	 end

	 def new_params
	 	hash = listing_params.dup
	 	hash[:tag_list] = hash[:tag_list].join(',')
		return hash
	 end
end