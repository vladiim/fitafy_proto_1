require 'spec_helper'

describe "Bookings" do
  
  before(:each) do
    @trainer = new_trainer
    @client = new_client
    @workout = Factory(:workout, :user_id => @trainer.id)
    @new_workout = Factory(:workout, :user_id => @trainer.id)
    @month = "March"
  end
  
  it "creates a booking" do
    visit root_path
    @trainer.train!(@client)
    integration_sign_in(@trainer)
    page.should have_css("label", :text => "Client")
    select("#{@client.username}", :from => "booking_client_id")
    select("#{@workout.title}", :from => "booking_workout_id")
    # check("Alive")
    # click_button("Create Booking")
    lambda do # selenium to select a jquery date until then use this shithouse test
      @trainer.bookings.create(:client => @client, :workout => @workout, :wo_date => 1.week.from_now)
    end.should change(Booking, :count).by(1)
  end
  
  describe "does stuff with an exsisting booking" do
    
    before(:each) do
      # integration_new_booking(@trainer, @client) need some testing majic for this to work 
      @booking = @trainer.bookings.create(:client => @client, :workout => @workout, :wo_date => 1.week.from_now)      
    end
    
    it "edits a booking from the booking page" do
      sign_in_visit_booking(@trainer, @booking)      
      click_link("Edit Booking")
      select("#{@new_workout.title}", :from => "booking_workout_id")
      click_button("Update Booking")
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
