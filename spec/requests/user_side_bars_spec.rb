require 'spec_helper'

describe "UserSideBars" do
  
  before(:each) do
    @trainer = new_trainer
    @client = new_client
    @trainer.train!(@client)
    integration_sign_in(@trainer)
  end
  
  it "shows the users side bar once they are signed in" do
    page.should have_content("#{@trainer.username}")
    page.should have_css("a", :text => "Clients: #{@trainer.training.count}")    
    page.should have_css("a", :text => "Bookings: #{@trainer.bookings.count}")    
    page.should have_css("a", :text => "Workouts: #{@trainer.workouts.count}")   
    page.should have_css("a", :text => "Exercises: #{Exercise.count}")                        
  end
  
  it "should take users to the right path" do
    click_link("Clients: #{@trainer.training.count}")
    current_path.should eq(training_user_path(@trainer))    
    click_link("Workouts: #{@trainer.workouts.count}")
    current_path.should eq(workouts_path)
    click_link("Bookings: #{@trainer.bookings.count}")
    current_path.should eq(bookings_path)
    click_link("Exercises: #{Exercise.count}")
    current_path.should eq(exercises_path)
  end
end