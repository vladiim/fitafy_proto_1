require 'spec_helper'

describe "Bookings" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @exercise = Factory(:exercise)
    @workout = Factory(:workout, user_id: @trainer.id, exercises: [@exercise])
    @new_workout = Factory(:workout, user_id: @trainer.id)
  end
  
  describe "no bookings" do
    
    it "redirects you from the booking path if you have no booking" do
      integration_sign_in(@trainer)
      click_link("Bookings: ")
      current_path.should eq(new_booking_path)
      page.should have_content("You have no bookings, why not make some?")
    end
  end
  
  describe "creating a booking" do
    
    it "creates a booking" do
      @trainer.train!(@client)
      sign_in_and_create_booking(@trainer, @client, @workout)
      page.should have_content("Booking created")
    end
  end

  describe "index" do
    
    it "index booking details are correct" do
      @destroy_booking = Factory(:booking, client: @client, trainer_id: @trainer.id, wo_date: 1.days.from_now, wo_time: "05:45")
      
      sign_in_visit_bookings(@trainer)
      page.should have_content(@destroy_booking.booking_time)
      page.should have_content(@destroy_booking.booking_date)
      page.should have_content(@destroy_booking.workout.title.titleize)

      click_link(@client.username.titleize)
      current_path.should eq(user_path(@client))
      visit bookings_path

      click_link("Visit")
      current_path.should eq(booking_path(@destroy_booking))
      visit bookings_path

      click_link("Edit")
      current_path.should eq(edit_booking_path(@destroy_booking))
      visit bookings_path

      click_link("Delete")
      page.should_not have_content(@destroy_booking.booking_time)
    end

    it "indexes bookings from the nearest date" do
      @booking3 = Factory(:booking, trainer_id: @trainer.id, wo_date: 3.days.from_now, wo_time: "05:45", workout_id: @workout.id)
      @booking = Factory(:booking, trainer_id: @trainer.id, wo_date: 1.days.from_now, wo_time: "05:45", workout_id: @workout.id)
      @booking4 = Factory(:booking, trainer_id: @trainer.id, wo_date: 4.days.from_now, wo_time: "05:45", workout_id: @workout.id)
      @booking2 = Factory(:booking, trainer_id: @trainer.id, wo_date: 2.days.from_now, wo_time: "05:45", workout_id: @workout.id)
      @trainer.bookings.should == [@booking, @booking2, @booking3, @booking4]
    end
  end
    
  describe "does stuff with an exsisting booking" do

    before(:each) do
      @booking = Factory(:booking, client: @client, trainer_id: @trainer.id, wo_date: 1.days.from_now, wo_time: "05:45", workout_id: @workout.id)
    end
    
    describe "show" do
      
      it "edits a booking from the booking page" do
        sign_in_visit_booking(@trainer, @booking)      
        click_link("Edit")
        select("#{@new_workout.title}", from: "booking_workout_id")
        click_button("Edit")
        page.should have_content("Booking updated")
      end

      it "destroys the booking" do
        Factory(:booking, trainer_id: @trainer.id) 
        # otherwise when you click_link("Delete") there are no more bookings 
        # and you get redirected from booking#index to booking#new
        
        sign_in_visit_booking(@trainer, @booking)
        click_link("Delete")
        page.should have_content("Booking deleted")
        current_path.should eq(bookings_path)
      end
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
