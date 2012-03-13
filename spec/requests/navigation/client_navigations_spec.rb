require 'spec_helper'

describe "Client Navigations" do
  
  before (:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @trainer.train!(@client)
    integration_sign_in(@client)
  end
  
  describe "as a brand new client" do

    it "my details lets a user edit their details" do
      click_link("My Details")
      current_path.should eq(edit_user_path(@client))
    end
    
    it "profile leads to users#show" do
      click_link("Profile")
      current_path.should eq(user_path(@client))
    end
    
    it "client with one trainer leads them to the trainer's path" do
      click_link("Trainer")
      current_path.should eq(user_path(@trainer))
    end
    
    it "clients can't see clients nav" do
      page.should_not have_css("a", text: "Clients:")
      page.should_not have_css("a", text: "Add New Client")
    end
    
    it "client can't see reverse_bookings if they have none" do
      click_link("My Bookings: 0")
      current_path.should eq(new_booking_path)
      page.should have_content("You have no bookings, why not make some?")
    end
    
    it "client can't create workout" do
      page.should_not have_css("a", text: "Create Workout")
    end
    
    it "with no workouts the client is led to new booking" do
      click_link("My Workouts: 0")
      current_path.should eq(new_booking_path)
      page.should have_content("You'll see your workouts once you finish a booking")
    end
    
    it "with no exercises the client is led to a new booking" do
      click_link("Exercises: 0")
      current_path.should eq(new_booking_path)
      page.should have_content("You'll see your exercises once you finish a booking")
    end
    
    it "signs the client out" do
      click_link("Sign Out") 
      current_path.should eq(root_path)
    end
  end  
  
  describe "as an experienced client" do
    
    before(:each) do
      @trainer2 = Factory(:trainer)
      @trainer2.train!(@client)
      @workout = Factory(:workout, user: @trainer)
      @booking = Factory(:booking, trainer_id: @trainer.id, client_id: @client.id)
      integration_sign_in(@client)
    end

    it "client with more than one client should lead them to a trainers list" do
      click_link("Trainers: 2")
      current_path.should eq(trained_by_user_path(@client))
    end
    
    it "with a booking should be able to visit reverse_bookings_path" do
      click_link("Bookings: 1")
      current_path.should eq(user_reverse_bookings_path(@client))      
    end
    
    it "shouldn't be able to see their workouts until a booking has been completed" do
      click_link("Workouts: 0")
      current_path.should eq(user_reverse_bookings_path(@client))
      page.should have_content("You'll see your workouts once you finish a booking")
    end
    
    it "shouldn't be able to see their exercises until a booking has been completed" do
      click_link("Exercises: 0")
      current_path.should eq(user_reverse_bookings_path(@client))
      page.should have_content("You'll see your exercises once you finish a booking")
    end
    
    describe "completed booking" do
      
      it "should be able to see the booking workout if the booking is completed" do
        click_link("Workouts: 1")
      end
      
      it "should be able to see the booking exercises if the booking is completed" do
        click_link("Exercises: 1")
      end
    end
  end
end