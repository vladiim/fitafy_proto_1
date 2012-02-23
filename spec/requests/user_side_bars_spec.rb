require 'spec_helper'

describe "UserSideBars" do
  
  before(:each) do
    @trainer = Factory(:user)
    integration_sign_in(@trainer)
  end
  
  describe "brand new trainer" do

    it "should take users to the right path" do
      click_link("Clients: #{@trainer.training.count}")
      current_path.should eq(training_user_path(@trainer))    
      click_link("Workouts: #{@trainer.workouts.count}")
      current_path.should eq(new_workout_path)
      click_link("Bookings: #{@trainer.bookings.count}")
      current_path.should eq(bookings_path)
      click_link("Exercises: #{Exercise.count}")
      current_path.should eq(exercises_path)
    end
  end
  
  describe "experienced trainer" do
    
    before(:each) do
      click_link("Sign Out")
      @client = Factory(:client)
      @experience_trainer = Factory(:user)
      @experience_trainer.train!(@client)
      @workout = Factory(:workout, user: @experience_trainer)
    end
    
    it "should take users to the right path" do
      integration_sign_in(@experience_trainer)
      click_link("Clients: #{@experience_trainer.training.count}")
      current_path.should eq(training_user_path(@experience_trainer))
      click_link("Workouts:")
      current_path.should eq(workouts_path)
      click_link("Bookings: #{@experience_trainer.bookings.count}")
      current_path.should eq(bookings_path)
      click_link("Exercises: #{Exercise.count}")
      current_path.should eq(exercises_path)
    end
  end
end
