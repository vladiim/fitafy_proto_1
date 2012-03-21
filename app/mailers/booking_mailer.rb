class BookingMailer < AsyncMailer
  default from: "no_reply@fitafy.com"
  default_url_options[:host] = "localhost:3000"
  
  # if Rails.env.production?
  #     default_url_options[:host] = "fitafy.com"
  # else
  #   default_url_options[:host] = "localhost:3000"
  # end
  
  def request_booking_proposed(sender, receiver)
    @url =          booking_requests_path
    @sender_name =  sender.username.titleize
    mail to:        receiver.email,
         subject:   "fitafy Booking Request from #{sender.username}",
         date:      Time.now
  end
  
  def request_booking_confirmed(sender, receiver, booking)
    @url =             booking_path(booking)
    @booking_details = "#{booking.booking_date} at #{booking.booking_time}"
    @sender_name =     sender.username.titleize
    mail to:           receiver.email,
         subject:      "fitafy Booking: Confirmed from #{sender.username}",
         date:         Time.now
  end
  
  def request_booking_declined(sender, receiver, booking)
    @url =             booking_path(booking)
    @booking_details = "#{booking.booking_date} at #{booking.booking_time}"
    @sender_name =     sender.username.titleize
    mail to:           receiver.email,
         subject:      "fitafy Booking: Declined from #{sender.username}",
         date:         Time.now
  end
  
  def request_booking_revised_time(sender, receiver, booking)
    @url =             booking_requests_path
    @booking_details = "#{booking.booking_date} at #{booking.booking_time}"
    @sender_name =     sender.username.titleize
    mail to:           receiver.email,
         subject:      "fitafy Booking: Suggested New Time from #{sender.username}",
         date:         Time.now
  end
end