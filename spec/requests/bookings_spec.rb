require 'spec_helper'

describe "Bookings" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @exercise = Factory(:exercise)
    @workout = Factory(:workout, user_id: @trainer.id, exercises: [@exercise])
    @new_workout = Factory(:workout, user_id: @trainer.id)
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
    
    it "index booking details are correct" do
      sign_in_visit_bookings(@trainer)
      page.should have_content(@booking.booking_date)
      page.should have_content(@booking.booking_time)
      page.should have_content(@booking.workout.title.titleize)
      page.should have_css("a", text: "#{@client.username.titleize}")
    end
    
    it "show booking details are correct" do
      sign_in_visit_booking(@trainer, @booking)
      page.should have_content(@booking.booking_date)
      page.should have_content(@booking.booking_time)
      click_link("#{@client.username.titleize}")
    end
    
    it "indexes bookings from the nearest date"
    
    it "edits a booking from the booking page" do
      sign_in_visit_booking(@trainer, @booking)      
      click_link("Edit Booking")
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
        sign_in_visit_booking(@trainer, @booking)
        fill_in "exercise_sets", with: 623
        fill_in "exercise_reps", with: 633        
        click_button("Update")
        page.should have_content("Exercise updated")
        current_path.should eq(booking_path(@booking))
        page.should have_css('input', value: 623)
      end
      
      it "adds an exercise to the booking" do
        @exercise2 = Factory(:exercise)
        sign_in_visit_booking(@trainer, @booking)
        click_link("Add More Exercises")
        check("exercise_#{@exercise2.id}")
        click_button("Add Exercises")
        page.should have_content("Booking updated")
        current_path.should eq(booking_path(@booking))
        page.should have_content(@exercise2.title)
      end
      
      it "removes an exercise" do
        sign_in_visit_booking(@trainer, @booking)
        click_link("Remove")
        page.should have_content("Exercise removed!")
        current_path.should eq(booking_path(@booking))
        page.should_not have_content(@exercise.title)
      end
      
      it "doesn't allow negative numbers for exercise sets" do
        sign_in_visit_booking(@trainer, @booking)
        fill_in "exercise_sets", with: -1
        click_button("Update")
        @booking.exercises.first.sets.should_not == -1
      end
      
      it "doesn't allow negative numbers for exercise reps" do
        sign_in_visit_booking(@trainer, @booking)
        fill_in "exercise_reps", with: -1
        click_button("Update")
        @booking.exercises.first.reps.should_not == -1
      end
    end
  end  
end
