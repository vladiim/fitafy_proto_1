require 'spec_helper'

describe "client bookings" do
  
  before(:each) do
    @trainer = Factory(:trainer)
    @client = Factory(:client)
    @trainer.train!(@client)
    integration_sign_in(@client)
  end
  
  describe "have no bookings" do
    
    describe "create booking details" do
      
      before(:each) do
        click_link("Request Booking")
      end
      
      it "new booking auto selects the trainer if there's only one trainer" do
        page.should have_content(@trainer.username.titleize)

        page.should_not have_css("label", text: "Workout")
        page.should_not have_css("label", text: "Message")
        page.should_not have_css("label", text: "Instructions")
        
        fill_in "booking_wo_date",   with: "#{1.day.from_now}"
        click_button("Request Booking")
        page.should have_content("Booking requested, your trainer will confirm the time")
        current_path.should eq(user_reverse_bookings_path(@client))
      end

      it "gives a selection if there's more than one trainer" do
        click_link("Sign Out")
        @trainer2 = Factory(:trainer)
        @trainer2.train!(@client)
        integration_sign_in(@client)
        click_link("Request Booking")

        select(@trainer2.username, from: "booking_trainer_id")
      end
      
      describe "client booking requests" do
        
        it "sends an email to the trainer to confirm the booking"
    
        it "trainer approves the booking, sends an email back"
    
        it "trainer declines the booking, sends an email back"
    
        it "trainer suggests a new time for the booking, sends email back"
      end
      
      describe "created booking" do
        
        it "indexes upcoming bookings correctly"
        
        it "has the trainer's name"
        
        it "doesn't have a workout listed"
      end
    end
  end
end