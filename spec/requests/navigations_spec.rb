require 'spec_helper'

describe "Navigations" do
  
  before (:each) do
    @trainer = Factory(:user)
    integration_sign_in(@trainer)
  end
  
  describe "as a brand new trainer" do

    it "should lead to the right pages" do
      click_link("Clients")
      current_path.should eq(training_user_path(@trainer))
      click_link("Bookings")
      current_path.should eq(bookings_path)    
      click_link("Workouts")
      current_path.should eq(new_workout_path)    
      click_link("My Account")
      current_path.should eq(edit_user_path(@trainer))    
      click_link("Clients: 0")
      current_path.should eq(training_user_path(@trainer))
      click_link("Bookings: 0")
      current_path.should eq(bookings_path)
      click_link("Workouts: 0")
      current_path.should eq(new_workout_path)    
      click_link("Exercises: 0")
      current_path.should eq(exercises_path)    
    end
  end  
  
  describe "as an experienced trainer" do
    
    before(:each) do
      @workout = Factory(:workout, user: @trainer)
    end

    it "should lead to the right pages" do
      click_link("Clients")
      current_path.should eq(training_user_path(@trainer))
      click_link("Bookings")
      current_path.should eq(bookings_path)    
      click_link("Workouts")
      current_path.should eq(workouts_path)    
      click_link("Clients: 0")
      current_path.should eq(training_user_path(@trainer))
      click_link("Bookings: 0")
      current_path.should eq(bookings_path)
      click_link("Workouts: 1")
      current_path.should eq(workouts_path)    
      click_link("Exercises:")
      current_path.should eq(exercises_path)    
    end
  end    
end
