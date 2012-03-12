require 'spec_helper'

describe "my profile" do

  before(:each) do
    @client = Factory(:client)
    @trainer = Factory(:trainer)
    @trainer.train!(@client)
    @admin = Factory(:admin)
  end

  describe "visiting my page" do

    describe "new client" do

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
        current_path.should eq(new_booking_path)
      end
    end
  end
end