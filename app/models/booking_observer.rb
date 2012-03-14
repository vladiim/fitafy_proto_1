class BookingObserver < ActiveRecord::Observer
  
  def after_create(booking)
    @booking = booking
    send_create_request
  end
  
  def after_update(booking)
    @booking = booking
    send_update_request
  end
  
  private
  
  def send_update_request
    if @booking.status == "confirmed"
      send_request_confirmed
    elsif @booking.status == "declined"
      send_request_declined
    elsif @booking.status == "revised_time"
      # send_request_revised_time(booking)
    else
      # log error
    end
  end

  # MY ATTEMPT AT DYNAMIC PROGRAMMING :( TRY AGAIN!
  # def send_request_response(booking, response_type)
  #   sender_and_receiver = find_sender_and_receiver(booking)
  #   BookingMailer.send "request_booking_#{response_type.to_s}".to_sym, (sender_and_receiver[0], sender_and_receiver[1]).deliver
  # end
  # def send_request_response(response_type)
  #   sender_and_receiver = find_sender_and_receiver
  #   mailer = BookingMailer.new
  #   mailer.eval{"request_booking_#{response_type.to_s}"(sender_and_receiver[0], sender_and_receiver[1])}
  # end
  
  def send_create_request
    sender_and_receiver = find_sender_and_receiver
    BookingMailer.request_booking_trainer_proposed(sender_and_receiver[0], sender_and_receiver[1]).deliver
  end
  
  def send_request_confirmed
    sender_and_receiver = find_sender_and_receiver
    BookingMailer.request_booking_confirmed(sender_and_receiver[0], sender_and_receiver[1], @booking).deliver
  end
  
  def send_request_declined
    sender_and_receiver = find_sender_and_receiver
    BookingMailer.request_booking_declined(sender_and_receiver[0], sender_and_receiver[1], @booking).deliver
  end
  
  def find_sender_and_receiver
    sender = find_sender
    receiver = find_receiver_based_on_sender(sender)
    sender_and_receiver = [sender, receiver]
  end
  
  def find_sender
    @sender = User.find(@booking.last_message_from)
  end

  def find_receiver_based_on_sender(sender)
    if @booking.trainer_id == sender.id
      receiver = User.find(@booking.client_id)
    elsif @booking.client_id == sender.id
      receiver = User.find(@booking.trainer_id)
    else
      puts "we got a problem yo booking_observer.rb line:69"
    end
  end
end