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

      it "page should show admin's workouts & exercises" do
        page.should have_css("a", text: "10 workouts")
        page.should have_css("a", text: "10 exercises")
      end
      
      it "shouldn't show booking information without a client" do
        page.should_not have_content("You have no bookings, why not create one?")
      end
      
      it "adds new client" do
        page.should have_content("You have no clients, why not invite one?")
        fill_in "client_email", with: "testi@email.com"
        click_button("Invite New Client")
        page.should have_content("New client invited!")
      end

      it "adds a new booking" do
        @client = Factory(:client)
        @trainer.train!(@client)
        click_link("Profile")
        page.should have_content("You have no bookings, why not create one?")
        click_link("Create Booking")
        current_path.should eq(new_booking_path)
      end
      
      it "creates a new workout" do
        page.should have_content("You haven't created any workouts. Here's some we prepared earlier:")
        click_link("create a new workout")
        current_path.should eq(new_workout_path)
      end
      
      it "creates a new exercise" do
        page.should have_content("You haven't created any exercises. Here's some we prepared earlier:")
        click_link("create a new exercise")
        current_path.should eq(new_exercise_path)
      end
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
      
      it "should show my clients" do
        page.should have_content("0 bookings")
        page.should have_content("12 bookings")
        click_link("13 clients")
        current_path.should eq(training_user_path(@trainer))
      end

      it "should show my bookings" do
        click_link("12 bookings")
        current_path.should eq(user_reverse_bookings_path(@client))
      end
      
      it "bookings should have link to booking" do
        click_link("06")
      end
      
      it "bookings should have link to client" do
        click_link(@client.username)
        current_path.should eq(user_path(@client))
      end
      
      it "go to my + admin's workouts" do
        integration_sign_in(@trainer)
        click_link("Profile")
        click_link("22 workouts")
        page.should have_css("a", text: "3")
        current_path.should eq(workouts_path)
      end

      it "go to my + admin's exercises" do
        integration_sign_in(@trainer)
        click_link("Profile")
        click_link("22 exercises")
        current_path.should eq(exercises_path)
      end
    end
  end
end