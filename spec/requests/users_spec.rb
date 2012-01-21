require 'spec_helper'

describe "Signups" do
  
  before(:each) do
    @trainer = new_trainer
  end
  
  it "signs up as a new trainer from the homepage" do
    integration_sign_up
    page.should have_content("Welcome")
    current_path.should eq(root_path)
    @trainer.role.should eq("trainer_role")
  end
  
  it "incorrectly signs a user in" do
    integration_sign_in(@trainer)
    click_link "Sign Out"
    fill_in "user_session_username", :with => "wrong"
    fill_in "user_session_password", :with => "wrong_again"
    click_button("Sign in")
    current_path.should eq(root_path)
    page.should have_content("Wrong email")
  end
  
  it "signs out then back in" do
    integration_sign_in(@trainer)
    click_link "Sign Out"
    current_path.should eq(root_path)
    page.should have_content("Start in minutes")
    integration_sign_in(@trainer)
    page.should_not have_content("Start in minutes")
  end
  
  it "can edit my details" do
    integration_sign_in(@trainer)
    click_link("My Account")
    current_path.should eq(edit_user_path(@trainer)) 
    fill_in "user_email", :with => "new_email@email.com"
    click_button("Update Profile")
    current_path.should eq(edit_user_path(@trainer))
    page.should have_content("Your details have been updated")
  end
  
  describe "signed in" do
    
    it "should be able to edit and manage profile details" do
      integration_sign_in(@trainer)
      click_link(@trainer.username.to_s)
      current_path.should eq(edit_user_path(@trainer))
      click_link("My Account")
      current_path.should eq(edit_user_path(@trainer))
      fill_in "user_email", :with => "new_email@email.com"
      click_button("Update Profile")
      page.should have_content("Your details have been updated")
    end
  end
  
  describe "signed in and dealing with other users" do
    
    before(:each) do
      @client = new_client
      @trainer.train!(@client)
    end
    
    it "goes to a client's profile page" do
      integration_sign_in(@trainer)
      click_link("Clients")
      click_link(@client.username.to_s)
      current_path.should eq(user_path(@client))
      page.should have_css("h2", :text => @client.username)
    end
  end
end
