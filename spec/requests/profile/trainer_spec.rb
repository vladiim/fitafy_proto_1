require 'spec_helper'

describe "my profile" do
  
  before(:each) do
    @trainer = Factory(:trainer)
    @admin = Factory(:admin)
    10.times do
      Factory(:workout, user_id: @admin.id)
      Factory(:exercise, user_id: @admin.id)
    end
  end
  
  describe "visiting my page" do

    describe "new trainer" do

      before(:each) do
        integration_sign_in(@trainer)
        click_link("Profile")
      end

      # it "page should show admin's workouts & exercises" do
      #   page.should have_css("a", text: "10 workouts")
      #   page.should have_css("a", text: "10 exercises")
      # end
      # 
      # it "shouldn't show booking information without a client" do
      #   page.should_not have_content("You have no bookings, why not create one?")
      # end
      # 
      # it "adds new client" do
      #   page.should have_content("Your only client is you! Why not invite some clients you can make money from?")
      #   fill_in "client_email", with: "testi@email.com"
      #   click_button("Invite New Client")
      #   page.should have_content("New client invited!")
      # end
      # 
      # it "adds a new booking" do
      #   @client = Factory(:client)
      #   @trainer.train!(@client)
      #   click_link("Profile")
      #   page.should have_content("You have no bookings, why not create one?")
      #   click_link("Create Booking")
      #   current_path.should eq(new_booking_path)
      # end
      # 
      # it "creates a new workout" do
      #   page.should have_content("You haven't created any workouts. Here's some we prepared earlier:")
      #   click_link("create a new workout")
      #   current_path.should eq(new_workout_path)
      # end
      # 
      # it "creates a new exercise" do
      #   page.should have_content("You haven't created any exercises. Here's some we prepared earlier:")
      #   click_link("create a new exercise")
      #   current_path.should eq(new_exercise_path)
      # end
    end
    
    describe "experienced trainer" do
      
      before(:each) do
        @client = Factory(:client)
        @trainer.train!(@client)
        12.times do
          @client_new = Factory(:client)
          @trainer.train!(@client_new)
          Factory(:workout, user_id: @trainer.id)
          Factory(:exercise, user_id: @trainer.id)
          Factory(:booking, trainer_id: @trainer.id, client_id: @client.id, wo_time: "06:44:00", last_message_from: @trainer.id)
        end
        integration_sign_in(@trainer)
        click_link("Profile")
      end
      
      # it "should show my clients" do
      #   page.should have_content("0 bookings")
      #   page.should have_content("12 bookings")
      #   click_link("14 clients")
      #   current_path.should eq(training_user_path(@trainer))
      # end
      # 
      # it "should show my bookings" do
      #   click_link("12 bookings")
      #   current_path.should eq(user_reverse_bookings_path(@client))
      # end
      # 
      # it "bookings should have link to booking" do
      #   click_link("06")
      # end
      # 
      # it "bookings should have link to client" do
      #   click_link(@client.username)
      #   current_path.should eq(user_path(@client))
      # end
      # 
      # it "go to my + admin's workouts" do
      #   integration_sign_in(@trainer)
      #   click_link("Profile")
      #   click_link("22 workouts")
      #   page.should have_css("a", text: "3")
      #   current_path.should eq(workouts_path)
      # end
      # 
      # it "go to my + admin's exercises" do
      #   integration_sign_in(@trainer)
      #   click_link("Profile")
      #   click_link("22 exercises")
      #   current_path.should eq(exercises_path)
      # end
    end
  end
  
  describe "visiting another trainer's page" do
    
    before(:each) do
      @new_trainer = Factory(:user)
      integration_sign_in(@trainer)
      visit user_path(@new_trainer)
    end
    
    describe "new trainer" do

      # it "should show client stats" do
      #   page.should have_css("td", id: "client-count", text: "1")
      # end
      # 
      # it "should show booking stats" do
      #   page.should have_css("td", id: "booking-count", text: "0")
      # end
      # 
      # it "should show workout stats" do
      #   page.should have_css("td", id: "workout-count", text: "0")
      # end
      # 
      # it "should show exercise stats" do
      #   page.should have_css("td", id: "exercise-count", text: "0")
      # end
      # 
      # it "should have a train user button" do
      #   click_button("Add Client")
      #   page.should have_content("Client invited")
      #   click_button("Remove Client")
      #   page.should have_content("Client removed")
      # end
      
      it "should have a train trainer button" do
        click_button("Add Trainer")
        page.should have_content("Trainer invited")
        click_button("Remove Trainer")
        page.should have_content("Trainer removed")
      end
    end
    
    describe "experienced trainer" do
      
      it "should show stuff on the trainer"
    end
  end
  
  describe "visiting another client's page" do
    
    describe "new client" do
      it "should show stuff on the client" 
    end
    
    describe "experienced client" do
      it "should show stuff on the client" 
    end
  end
end