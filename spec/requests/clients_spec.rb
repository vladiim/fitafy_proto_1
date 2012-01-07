require 'spec_helper'

describe "Clients" do
  before(:each) do
    @trainer = Factory.build(:user)
    @client = Factory.build(:user)
    @trainer.save_without_session_maintenance
    @client.save_without_session_maintenance
  end
  
  it "trains! and untrains! a client who is in the system" do
    integration_sign_in(@trainer)
    page.should have_content("Create a booking")
    visit user_path(@client)
    page.should have_content("#{@client.username}")    
    click_button("Add client")
    page.should have_content("Client invited")
    click_button("Remove client")
    page.should have_content("Client removed")
  end
  
  it "views a list of the trainer's clients" do
    @trainer.train!(@client)     
    integration_sign_in(@trainer)    
    current_path.should eq(root_path)   
    click_link("Clients: #{@trainer.training.count}")
    current_path.should eq(training_user_path(@trainer))
    page.should have_css("a", :text => "#{@client.username}")   
    page.should have_css("a", :text => "Create Booking")    
    page.should have_css("a", :text => "x Completed Bookings")     
    page.should have_css("a", :text => "x Uncompleted Bookings")     
  end
end
