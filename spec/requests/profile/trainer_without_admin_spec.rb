require 'spec_helper'

describe "Trainer Profile Without Admin" do
  
  before(:each) do
    @trainer = Factory(:user)
    integration_sign_in(@trainer)
  end
  
  it "should still show a profile without an admin user" do
    click_link("Profile")
    page.should have_content("Your only client is you! Why not invite some clients you can make money from?")
  end
end