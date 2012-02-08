require 'spec_helper'

describe "Bookings" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @workout = Factory(:workout, user_id: @trainer.id)
    @new_workout = Factory(:workout, user_id: @trainer.id)
    @month = "March"
  end
  
  it "creates a booking" do
    visit root_path
    @trainer.train!(@client)
    integration_sign_in(@trainer)
    page.should have_css("label",   text: "Client")
    select("#{@client.username}",   from: "booking_client_id")
    select("#{@workout.title}",     from: "workout_id")
    fill_in "booking_wo_date",      with: 1.day.from_now
    click_button "Create Booking"
    page.should have_content("Booking created")
  end
  
  describe "does stuff with an exsisting booking" do
    
    before(:each) do
      @booking = Factory(:booking, client: @client, trainer: @trainer, wo_time: "05:45", workout: @workout)
    end
          
    it "shows the details for the booking" do
      sign_in_visit_booking(@trainer, @booking)
      page.should have_content(@booking.booking_date)
      page.should have_content(@booking.booking_time)
      page.should have_css("a", text: @booking.workout.title)
      click_link("#{@client.username.titleize}")
      page.should have_css("h2", text: @client.username)
    end
    
    it "edits a booking from the booking page" do
      sign_in_visit_booking(@trainer, @booking)      
      click_link("Edit Booking")
      select("#{@new_workout.title}", from: "workout_id")
      click_button("Edit Booking")
      page.should have_content("Booking updated")
    end

    it "edits a booking from the index page" do
      integration_sign_in(@trainer)      
      click_link("Bookings")
      click_link("#{@booking.client.username.titleize}")
      select("#{@new_workout.title}", from: "workout_id")
      click_button("Edit Booking")
      page.should have_content("Booking updated")
    end

    it "destroys the booking" do
      sign_in_visit_booking(@trainer, @booking)
      click_link("Delete Booking")
      page.should have_content("Booking deleted")
      current_path.should eq(bookings_path)
    end
  end  
end
