class ReservationsController < ApplicationController


  before_action :find_reservation, only: [:show, :edit, :update, :destroy]

  def new
    @reserve = Reservation.new
  end

  def index
    @listing = Listing.find(params[:listing_id])
      # byebug
      unless current_user.reservations == nil
        @reserve = Reservations.find(params[:id])
      end
  end

  def show
    @listing = @reserve.listing
    @client_token = Braintree::ClientToken.generate
  end

  def create
    # byebug
    @listing = Listing.find(params[:listing_id])      

    date = params[:reservation][:dates]

    split_date = date.split(' - ')
               
    check_in_date = split_date[0]
    check_out_date = split_date[1]
    # byebug
    check_in = DateTime.parse(check_in_date).strftime("%d-%m-%Y")
    check_out = DateTime.parse(check_out_date).strftime("%d-%m-%Y")

    @reserve = Reservation.new(check_in: check_in, check_out: check_out, listing_id: params[:reservation][:listing_id])
    @reserve.user_id = current_user.id
    # byebug

    #booking days is calculated from check-in date until check-out date
    @booking_days = @reserve.check_out - @reserve.check_in
    @booking_days.to_i
    @reserve.amount = @booking_days.to_i * @reserve.listing.price

    if @reserve.save
      @customer = @reserve.user
      @host = User.find(@reserve.listing.user_id)
      reserve_id = @reserve.id
      ReservationJob.perform_later(@customer, @host, reserve_id)
      redirect_to listing_reservation_path(params[:listing_id], @reserve)
      flash.now[:success]="Yeayyy, next paylah"
    else
      flash.now[:danger] = "Date is unavailable, perhaps another?"
      render :index
    end
  end

  def edit
  end

  def update
      if @reserve.update(reserve_params)
        redirect_to reservations_index_path
      else
        flash[:warning] = "You sure bout this update?"
        render :index
      end
  end

  def destroy
    @reserve.destroy
    redirect_to reservations_index_path
  end


private

  def find_reservation
    @reserve = Reservation.find(params[:id])
  end

  def reserve_params
    params.require(:reservation).permit(
      :user_id, :listing_id, 
      :check_in, :check_out, 
      :datefilter)
  end

end
