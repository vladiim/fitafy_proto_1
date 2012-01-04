require 'spec_helper'

describe "Signups" do
  
  before(:each) do
    @trainer = Factory.build(:user)
  end
  
  it "signs up as a new trainer from the homepage" do
    integration_sign_up(@trainer)
    page.should have_content("Welcome")
    current_path.should eq(root_path)
  end
  
  it "incorrectly signs a user in" do
    visit root_path
    fill_in "user_session_username", :with => "wrong"
    fill_in "user_session_password", :with => "wrong_again"
    click_button("Sign in")
    current_path.should eq(root_path)
    page.should have_content("Wrong email")
  end
  
  it "signs out then back in" do
    integration_sign_up(@trainer)
    click_link "Sign out"
    current_path.should eq(root_path)
    page.should have_content("Start in minutes")
    integration_sign_in(@trainer)
    page.should_not have_content("Start in minutes")
  end
end
