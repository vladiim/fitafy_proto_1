require 'spec_helper'

describe "client profile" do

  before(:each) do
    @client = Factory(:client)
    @trainer = Factory(:trainer)
    @trainer.train!(@client)
    @admin = Factory(:admin)
  end

  describe "visiting my page" do

    before(:each) do
      integration_sign_in(@client)
      click_link("Profile")
    end

    it "should show link to trainer's profile" do
      click_link(@trainer.username.titleize)
      current_path.should eq(user_path(@trainer))
    end
    
    it "should drive the client to request a booking time with the trainer" do
      page.should have_content("You have no bookings yet, why don't you request one?")
      click_link("Request Booking")
      current_path.should eq(new_booking_request_path)
    end
  end
  
  describe "visiting a trainer's page" do
    
    before(:each) do
      integration_sign_in(@client)
      visit user_path(@trainer)
    end
    
    it "should show client stats" do
      page.should have_css("td", id: "client-count", text: "2")
    end
    
    it "should show booking stats" do
      page.should have_css("td", id: "booking-count", text: "0")
    end
    
    it "should show workout stats" do
      page.should have_css("td", id: "workout-count", text: "0")
    end
    
    it "should show exercise stats" do
      page.should have_css("td", id: "exercise-count", text: "0")
    end
    
    it "should not have an add as client button" do
      page.should_not have_css("input", text: "Add Client")
    end
    
    it "should have a train trainer button" do
      click_button("Remove Trainer")
      page.should have_content("Trainer removed")
      visit user_path(@trainer)
      click_button("Add Trainer")
      page.should have_content("Trainer invited")
    end
  end
end