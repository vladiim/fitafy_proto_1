class BookingObserver < ActiveRecord::Observer
  
  def after_create(booking)
    send_create_request(booking)
  end
  
  def after_update(booking)
    send_update_request(booking)
  end
  
  private
  
  def send_create_request(booking)
    request_sender = find_sender(booking)
    request_receiver = find_receiver_based_on_sender(request_sender, booking)
    BookingMailer.request_booking_create(request_sender, request_receiver).deliver
  end
  
  def send_update_request(booking)
    if booking.status == "confirmed"
      send_request_confirmed(booking)
    elsif booking.status == "declined"
      # send_request_delined(booking)
    elsif booking.status == "revised_time"
      # send_request_revised_time(booking)
    else
      # log error
    end
  end
  
  def send_request_confirmed(booking)
    sender = find_sender(booking)
    receiver = find_receiver_based_on_sender(sender, booking)
    BookingMailer.request_booking_confirmed(sender, receiver, booking).deliver
  end
  
  def find_sender(booking)
    @sender = User.find(booking.request_from)
  end

  def find_receiver_based_on_sender(request_sender, booking)
    if booking.trainer_id == request_sender.id
      receiver = User.find(booking.client_id)
    elsif booking.client_id == request_sender.id
      receiver = User.find(booking.trainer_id)
    else
      puts "we got a problem yo"
    end
  end
end
