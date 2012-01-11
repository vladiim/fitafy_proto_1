require 'spec_helper'

describe "Signups" do
  
  before(:each) do
    @trainer = new_trainer
  end
  
  it "signs up as a new trainer from the homepage" do
    integration_sign_in(@trainer)
    page.should have_content("Welcome")
    current_path.should eq(root_path)
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
    click_button("Update Details")
    current_path.should eq(edit_user_path(@trainer))
    page.should have_content("Your details have been updated")
  end
end
