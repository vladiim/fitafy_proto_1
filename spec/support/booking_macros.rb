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
end