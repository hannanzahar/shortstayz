class UsersController < Clearance::UsersController
 	before_action :check_user, only: [:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def profile
		@user = current_user
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
	@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			flash[:warning] = "Y U DO DIS"
			render :edit
		end

	end

	private

	def user_params
		params.require(:user).permit(
			:email, :password, :phone_num, 
			:first_name, :last_name, :gender, 
			:birthdate, :phone_num, :address, 
			:subscribe, :avatar, :reservations)
	end

	def check_user
		unless current_user == User.find(params[:id])
			flash[:warning] = 'Y U DO DIS AGAIN'
			redirect_to '/'
		end
	end
  
end
