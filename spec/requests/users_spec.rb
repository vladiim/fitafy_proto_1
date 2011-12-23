require 'spec_helper'

describe "Signups" do
  
  before(:each) do
    @trainer = Factory.build(:user)
  end
  
  it "signs up as a new trainer from the homepage" do
    integration_sign_up(@trainer)
    page.should have_content("Welcome to fitafy!")
    current_path.should eq(root_path)
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
