require 'spec_helper'

describe "Bookings" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @workout = Factory(:workout, user_id: @trainer.id)
    @new_workout = Factory(:workout, user_id: @trainer.id)
    # @month = "March"
  end
  
  describe "creating a booking" do
    
    it "creates a booking" do
      @trainer.train!(@client)
      sign_in_and_create_booking(@trainer, @client, @workout)
      page.should have_content("Booking created")
    end
  end
  
  describe "does stuff with an exsisting booking" do
    
    before(:each) do
      @booking = Factory(:booking, client: @client, trainer_id: @trainer.id, wo_time: "05:45", workout_id: @workout.id)
    end
          
    it "shows the details for the booking" do
      sign_in_visit_booking(@trainer, @booking)
      page.should have_content(@booking.booking_date)
      page.should have_content(@booking.booking_time)
      page.should have_content(@booking.workout.title)
      click_link("#{@client.username.titleize}")
    end
    
    it "edits a booking from the booking page" do
      sign_in_visit_booking(@trainer, @booking)      
      click_link("Edit Booking")
      select("#{@new_workout.title}", from: "booking_workout_id")
      click_button("Edit Booking")
      page.should have_content("Booking updated")
    end

    it "edits a booking from the index page" do
      integration_sign_in(@trainer)      
      click_link("Bookings")
      click_link("#{@booking.client.username.titleize}")
      select("#{@new_workout.title}", from: "booking_workout_id")
      click_button("Edit Booking")
      page.should have_content("Booking updated")
    end

    it "destroys the booking" do
      sign_in_visit_booking(@trainer, @booking)
      click_link("Delete Booking")
      page.should have_content("Booking deleted")
      current_path.should eq(bookings_path)
    end
    
    describe "editing the booking exercise details" do
      
      it "changes the sets and reps" do
        # sign_in_visit_booking(@trainer, @booking)
        integration_sign_in(@trainer)
        visit booking_path(@booking)
        fill_in "exercise_sets", with: 6
        fill_in "exercise_reps", with: 6        
        click_button("Update Exercise")
        page.should have_content("Exercise updated")
      end
    end
  end  
end
