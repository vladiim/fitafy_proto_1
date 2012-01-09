module BookingMacros
  
  def integration_new_booking(trainer, client)
    visit root_path
    trainer.train!(client)
    integration_sign_in(trainer)
    select("#{client.username}", :from => "booking_client_id")
    select("December", :from => "booking_date_time_2i")    
    click_button("Create Booking")
  end
end