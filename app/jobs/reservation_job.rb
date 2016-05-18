class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    ReservationMailer.booking_email(args[0], args[1], args[2]).deliver_now
  end
end
