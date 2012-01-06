require 'spec_helper'

describe "Clients" do
  before(:each) do
    @trainer = Factory.build(:user)
    @trainer.save_without_session_maintenance
    @client = Factory(:user)
    integration_sign_in(@trainer)
  end
  
  it "trains! and untrains! a client who is in the system" do
    page.should have_content("Create a booking")
    page.select("Invite new client", :from => "user_clients")
    fill_in "user_clients_new", :with => @client.email
    click_button("Invite new client")
    page.should have_content("Someone with that email is already registered")
    click_link("Add as client")
    page.should have_content("Client added")
  end
  
  it "trains! a client who isn't in the system'" 
  
  it "can't train the same client twice (note: add uniqueness to migration)"
  
  it "destroys the relationship if the user is destroyed (hm :relationships, :dependent => :destroy)"
end
