require 'spec_helper'

describe "UserSideBars" do
  
  before(:each) do
    @trainer = Factory.build(:user)
    @trainer.save_without_session_maintenance
    integration_sign_in(@trainer)
  end
  
  it "shows the users side bar once they are signed in" do
    page.should have_content("#{@trainer.username}")
    page.should have_css("a", :text => "Clients:")    
    page.should have_css("a", :text => "Bookings:")    
    page.should have_css("a", :text => "Workouts:")                    
  end
end
