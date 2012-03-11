require 'spec_helper'

describe "Signups" do
  
  before(:each) do
    @trainer = Factory(:user)
  end
  
  it "signs up as a new trainer from the homepage" do
    integration_sign_up
    page.should have_content("Welcome")
    current_path.should eq(root_path)
    @trainer.role.should eq("trainer_role")
  end
  
  it "fails to sign up as a new trainer with bad details" do
    visit root_path
    click_link("Start Using fitafy!")
    fill_in "user_username", with: "b"
    fill_in "user_email", with: "b@b"
    fill_in "user_password", with: "b"
    fill_in "user_password_confirmation", with: "b"
    click_button("Sign Up")
    
    page.should have_content("Oops! There are some errors")
    page.should have_content("minimum is 3 characters")
    page.should have_content("should look like an email address")
    page.should have_content("(minimum is 4 characters)")
    page.should have_css("input", value: "Sign Up")
  end
  
  it "signs in then out" do
    integration_sign_in(@trainer)
    page.should_not have_content("Start in minutes")
    click_link "Sign Out"
    current_path.should eq(root_path)
    page.should have_content("You train your clients")
  end
  
  it "incorrectly signs a user in" do
    integration_sign_in(@trainer)
    click_link "Sign Out"
    fill_in "user_session_username", with: "wrong"
    fill_in "user_session_password", with: "wrong_again"
    click_button("Sign in")
    current_path.should eq(root_path)
    page.should have_content("Wrong email")
  end
  
  it "can edit my details" do
    integration_sign_in(@trainer)
    click_link("My Profile")
    current_path.should eq(edit_user_path(@trainer)) 
    fill_in "user_email", with: "new_email@email.com"
    click_button("Update Profile")
    current_path.should eq(edit_user_path(@trainer))
    page.should have_content("Your details have been updated")
  end
  
  describe "signed in" do
    
    it "should be able to edit and manage profile details" do
      integration_sign_in(@trainer)
      click_link("My Profile")
      current_path.should eq(edit_user_path(@trainer))
      fill_in "user_email", with: "new_email@email.com"
      click_button("Update Profile")
      page.should have_content("Your details have been updated")
    end
  end
  
  describe "signed in and dealing with other users" do
    
    before(:each) do
      @client = Factory(:client)
      @trainer.train!(@client)
    end
    
    it "goes to a client's profile page" do
      integration_sign_in(@trainer)
      click_link("Clients: ")
      click_link(@client.username.titleize)
      current_path.should eq(user_path(@client))
    end
  end
end
