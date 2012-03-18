require 'spec_helper'

describe "Trainer Navigations" do
  
  before (:each) do
    @trainer = Factory(:user)
    integration_sign_in(@trainer)
    @admin = Factory(:admin)
  end
  
  describe "as a brand new trainer" do

    it "my details leads a trainer to users#edit" do
      click_link("My Details")
      current_path.should eq(edit_user_path(@trainer))    
    end
    
    it "profile leads a trainer to the users#show path" do
      click_link("Profile")
      current_path.should eq(user_path(@trainer))    
    end
    
    it "if a trainer has no clients the clients#index redirects them to new_client" do
      click_link("Clients: 1")
      current_path.should eq(new_client_path)
    end
    
    it "if a trainer has no bookings bookings_path redirects to new_booking" do
      click_link("Bookings: 0")
      current_path.should eq(new_booking_path)
    end
    
    it "if a trainer has no workouts workouts_path redirects to new_workout" do
      click_link("Workouts: 0")
      current_path.should eq(new_workout_path)
    end
    
    it "if a trainer has no exercises exercises_path redirects to new_exercise" do
      click_link("Exercises: 0")
      current_path.should eq(exercises_path)   
    end
    
    it "signs out" do
      click_link("Sign Out") 
      current_path.should eq(root_path)
      page.should have_content("Signed out!")
    end
  end  
  
  describe "as an experienced trainer" do
    
    before(:each) do
      @workout = Factory(:workout, user: @trainer)
      @booking = Factory(:booking, trainer_id: @trainer.id, last_message_from: @trainer.id)
      @client = Factory(:client)
      @trainer.train!(@client)
      integration_sign_in(@trainer)
    end

    it "with a client, clients_path works" # do
    #       click_link("Clients: 1")
    #       current_path.should eq(training_user_path(@trainer))
    #     end
    
    it "with a booking, bookings_path works" do
      click_link("Bookings: 1")
      current_path.should eq(bookings_path)
    end
    
    it "with a workout, workouts_path works" do
      click_link("Workouts: 1")
      current_path.should eq(workouts_path)
    end
    
    it "with an exercise, exercises_path works" do
      click_link("Exercises:")
      current_path.should eq(exercises_path)
    end
    
    describe "invites" do

      it "should have booking invites nav if they have booking invites" do
        @booking = Factory(:booking, trainer_id: @trainer.id, client_id: @client.id, last_message_from: @client.id, status: "client_proposed")
        integration_sign_in(@trainer)
        click_link("Booking Invites: 1")

        current_path.should eq(booking_invites_path)
      end
    end
  end
  
  describe "trainer who has made workouts for themself" do

    it "has my bookings with a self made workout" do
      @workout = Factory(:workout, user_id: @trainer.id)
      visit new_booking_path

      select(@trainer.username,      from: "booking_client_id")
      select(@workout.title,         from: "booking_workout_id")
      fill_in "booking_wo_date",     with: "#{1.day.from_now}"
      fill_in "booking_message",     with: "This is a message yo"
      click_button("Create Booking")

      page.should have_content("Booking created!")
    end
  end
end