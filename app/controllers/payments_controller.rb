class PaymentsController < ApplicationController
	before_action :find_reservation

	def new
		@client_token = Braintree::ClientToken.generate
		@payment = Payment.new
	end

	def create
		nonce = params[:payment_method_nonce]
		render action: :new and return unless nonce
		result = Braintree::Transaction.sale(
			amount: @reserve.amount,
			payment_method_nonce: "fake-valid-nonce"
		)
		@payment = Payment.new

		if result.success?
			@payment.amount = @reserve.amount
			@payment.user_id = current_user.id
			@payment.reservation_id = @reserve.id
			@payment.save
			# byebug
			ReservationJob.perform_later(@reserve.user_id, @reserve.listing.user_id, @reserve.id)
			redirect_to new_reservation_payment_path
			flash[:success]="Kudos, enjoy your trip."
		else
			flash[:danger]="Unsuccessful payment, please check your details."
			redirect_to listing_reservation_path(@reserve.listing, @reserve)
		end
	end

private

	def find_reservation
		@reserve = Reservation.find(params[:reservation_id])
	end

	def auth_user
		unless @reserve.user_id == current_user.id
			flash[:alert]="Invalid user"
			redirect_to[:back]
		end
	end

end
