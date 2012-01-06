require 'spec_helper'

describe "Navigations" do
  
  before (:each) do
    @trainer = Factory.build(:user)
    @trainer.save_without_session_maintenance
    integration_sign_in(@trainer)
  end
  
  it "should have the correct navigation links" do
    page.should have_css("a", :text => "Clients")
    page.should have_css("a", :text => "Bookings")    
    page.should have_css("a", :text => "Workouts")
    page.should have_css("a", :text => "Contact")
    page.should have_css("a", :text => "My Account")
    page.should have_css("a", :text => "Sign out")                
  end
end
