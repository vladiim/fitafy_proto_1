module BookingMacros
  
  def create_booking(trainer, client, workout)
    select(client.username,      from: "booking_client_id")
    select(workout.title,        from: "booking_workout_id")
    fill_in "booking_wo_date",   with: "#{1.day.from_now}"
    fill_in "booking_message",   with: "This is a message yo"
    click_button("Create Booking")
  end
  
  def integration_new_booking(trainer, client)
    visit root_path
    trainer.train!(client)
    integration_sign_in(trainer)
    select("#{client.username}", from: "booking_client_id")  
    click_button("Create Booking")
  end
  
  def sign_in_visit_booking(trainer, booking)
    integration_sign_in(trainer)
    visit booking_path(booking)
  end
  
  def sign_in_visit_bookings(trainer)
    integration_sign_in(trainer)
    visit bookings_path
  end
  
  def sign_in_visit_reverse_bookings(client)
    integration_sign_in(client)
    visit user_reverse_bookings_path(client)
  end

  def sign_in_and_create_booking(trainer, client, workout)
    integration_sign_in(trainer)
    create_booking(trainer, client, workout)
  end
end