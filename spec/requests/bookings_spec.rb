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
    page.should have_css("label", text: "Client")
    select("#{@client.username}", from: "booking_client_id")
    select("#{@workout.title}", from: "workout_id")
    lambda do # selenium to select a jquery date until then use this shithouse test
      @trainer.bookings.create(client_id: @client.id, workout: @workout, wo_date: 1.week.from_now)
    end.should change(Booking, :count).by(1)
  end
  
  describe "does stuff with an exsisting booking" do
    
    before(:each) do
      @booking = Factory(:booking, client: @client, trainer: @trainer, wo_time: "05:45")
    end
          
    it "shows the details for the booking" do
      sign_in_visit_booking(@trainer, @booking)
      # page.should have_content(@booking.booking_date)
      page.should have_content(@booking.booking_time)
      page.should have_content(@booking.message)
      # page.should have_css("a", text: @booking.workout.title)
      click_link("#{@client.username}")
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
      click_link("#{@booking.client.username}")
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
