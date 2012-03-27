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
    
    it "creates a booking for a client" do
      @trainer.train!(@client)
      sign_in_and_create_booking(@trainer, @client, @workout)
      page.should have_content("Booking created")
    end
    
    it "creates a booking for themself" do
      @trainer.train!(@client)
      sign_in_and_create_booking(@trainer, @trainer, @workout)
      page.should have_content("Booking created")
    end
    
    describe "trainer booking requests" do
      
      it "redirects you from the booking request index if it's empty" do
        integration_sign_in(@trainer)
        visit booking_requests_path
        current_path.should eq(new_booking_path)
        page.should have_content("You have no booking requests, why not send one?")
      end

      before(:each) do
        @trainer.train!(@client)
        sign_in_and_create_booking(@trainer, @client, @workout)
        click_link("Sign Out")
        integration_sign_in(@client)
        visit booking_requests_path
      end
      
      it "sends an email to the client to confirm the booking" do
        last_email.to.should include(@client.email)
        last_email.body.should include(booking_requests_path)
      end

      it "client approves the booking, sends an email back" do
        click_button("Confirm")
        last_email.to.should include(@trainer.email)
        last_email.body.should include("#{@client.username.titleize} has confirmed your booking on")
      end
  
      it "client declines the booking, sends an email back" do
        click_button("Decline")
        last_email.to.should include(@trainer.email)
        last_email.body.should include("#{@client.username.titleize} has declined your booking on")
        last_email.body.should include("You can suggest a new time or delete the booking")
      end
  
      it "client suggests a new time for the booking, sends email back" do
        click_link("Suggest New Time")
        fill_in "booking_wo_date",   with: "#{1.day.from_now}"
        click_button("Suggest New Time")
        
        last_email.to.should include(@trainer.email)
        last_email.body.should include(booking_requests_path)
      end
    end
  end
  
  describe "index" do
      
    before(:each) do
      @destroy_booking = Factory(:booking, client_id: @client.id, trainer_id: @trainer.id, wo_date: 1.days.from_now, wo_time: Time.now, last_message_from: @trainer.id)
      sign_in_visit_bookings(@trainer)
    end
    
    it "should have the booking time" do
      page.should have_content(@destroy_booking.booking_time)
    end
    
    it "should have the booking date" do
      page.should have_content(@destroy_booking.booking_date)
    end
    
    it "should have the workout title" do
      page.should have_content(@destroy_booking.workout.title.titleize)
    end
    
    it "should link to the client's profile" do
      click_link(@client.username.titleize)
      current_path.should eq(user_path(@client))
    end
    
    it "should lead to the booking page" do
      click_link("Visit")
      current_path.should eq(booking_path(@destroy_booking))
    end
    
    it "should be able to edit the booking" do
      click_link("Edit")
      current_path.should eq(edit_booking_path(@destroy_booking))
    end
    
    it "should be able to delete the booking" do
      click_link("Delete")
      page.should_not have_content(@destroy_booking.booking_time)
    end
  
    it "indexes bookings from the nearest date" do
      @booking3 = Factory(:booking, trainer_id: @trainer.id, last_message_from: @trainer.id, wo_date: 3.days.from_now, wo_time: Time.now, workout_id: @workout.id)
      @booking = Factory(:booking, trainer_id: @trainer.id, last_message_from: @trainer.id, wo_date: 1.days.from_now, wo_time: Time.now, workout_id: @workout.id)
      @booking4 = Factory(:booking, trainer_id: @trainer.id, last_message_from: @trainer.id, wo_date: 4.days.from_now, wo_time: Time.now, workout_id: @workout.id)
      @booking2 = Factory(:booking, trainer_id: @trainer.id, last_message_from: @trainer.id, wo_date: 2.days.from_now, wo_time: Time.now, workout_id: @workout.id)
      
      # @trainer.bookings.should == [@booking, @booking2, @booking3, @booking4] fucked if I know how to do this... one day :)
    end
  end
    
  describe "does stuff with an exsisting booking" do
  
    before(:each) do
      @booking = Factory(:booking, client: @client, trainer_id: @trainer.id, last_message_from: @trainer.id, wo_date: 1.days.from_now, wo_time: Time.now, workout_id: @workout.id)
    end
    
    describe "show" do
      
      it "edits a booking from the booking page" do
        sign_in_visit_booking(@trainer, @booking)      
        click_link("Edit")
        select("#{@new_workout.title}", from: "booking_workout_id")
        fill_in "booking_instructions", with: "New instructions mo fo"
        click_button("Edit")
        page.should have_content("Booking updated")
      end
  
      it "destroys the booking" do
        Factory(:booking, trainer_id: @trainer.id, last_message_from: @trainer.id) 
        # otherwise when you click_link("Delete") there are no more bookings 
        # and you get redirected from booking#index to booking#new
        
        sign_in_visit_booking(@trainer, @booking)
        click_link("Delete")
        page.should have_content("Booking deleted")
        current_path.should eq(bookings_path)
      end
      
      it "redirects you from bookings_path to new_booking_path if you click on a '0 bokings' link" do
        @client2 = Factory(:client)
        @trainer.train!(@client2)
        @admin = Factory(:admin)
        integration_sign_in(@trainer)
        click_link("Profile")
        
        click_link("0 bookings")
        current_path.should eq(new_booking_path)
        page.should have_content("There were no bookings for that client, why not make some?")
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
