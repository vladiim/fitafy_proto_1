require 'spec_helper'

describe "Navigations" do
  
  before (:each) do
    @trainer = new_trainer
    integration_sign_in(@trainer)
  end
  
  it "should have the correct navigation links" do
    page.should have_css("a", :text => "Clients")
    page.should have_css("a", :text => "Bookings")    
    page.should have_css("a", :text => "Workouts")
    page.should have_css("a", :text => "Contact")
    page.should have_css("a", :text => "My Account")
    page.should have_css("a", :text => "Sign Out")                
  end
  
  it "should lead to the right pages" do
    click_link("Clients")
    current_path.should eq(training_user_path(@trainer))
    click_link("Bookings")
    current_path.should eq(bookings_path)    
    click_link("Workouts")
    current_path.should eq(workouts_path)    
    click_link("My Account")
    current_path.should eq(edit_user_path(@trainer))    
    click_link("Clients: 0")
    current_path.should eq(training_user_path(@trainer))
    click_link("Bookings: 0")
    current_path.should eq(bookings_path)
    click_link("Workouts: 0")
    current_path.should eq(workouts_path)    
    click_link("Exercises: 0")
    current_path.should eq(exercises_path)    
  end
end
