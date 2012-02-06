module BookingMacros
  
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

  def sign_in_and_create_booking(trainer, client, workout)
    integration_sign_in(trainer)
    select(client.username,      from: "booking_client_id")
    select(workout.title,        from: "workout_id")
    fill_in "booking_wo_date",   with: 1.day.from_now
    click_button("Create Booking")
  end  
end