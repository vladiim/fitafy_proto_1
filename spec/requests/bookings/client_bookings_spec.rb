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

        it "redirects you from the booking request index if it's empty" do
          integration_sign_in(@client)
          visit booking_requests_path
          current_path.should eq(new_booking_path)
          page.should have_content("You have no booking requests, why not send one?")
        end

        before(:each) do
          @reverse_booking = Factory(:client_booking, client_id: @client.id, last_message_from: @client.id, trainer_id: @trainer.id)
          integration_sign_in(@trainer)
          visit booking_invites_path
        end

        it "sends an email to the trainer to confirm the booking" do
          last_email.to.should include(@trainer.email)
          last_email.body.should include(booking_requests_path)
        end

        it "trainer approves the booking, sends an email back" do
          click_button("Confirm")
          last_email.to.should include(@client.email)
          last_email.body.should include("#{@trainer.username.titleize} has confirmed your booking on")
        end

        it "client declines the booking, sends an email back" do
          click_button("Decline")
          last_email.to.should include(@client.email)
          last_email.body.should include("#{@trainer.username.titleize} has declined your booking on")
          last_email.body.should include("You can suggest a new time or delete the booking")
        end

        it "suggests a new time for the booking, sends email back" do
          click_link("Suggest New Time")
          fill_in "booking_wo_date",   with: "#{1.day.from_now}"
          click_button("Suggest New Time")

          last_email.to.should include(@trainer.email)
          last_email.body.should include(booking_requests_path)
        end
      end
    end
  end
  
  describe "created booking" do
    
    before(:each) do
      @booking = Factory(:booking, trainer_id: @trainer.id,  last_message_from: @trainer.id, client_id: @client.id)
      sign_in_visit_reverse_bookings(@client)
    end
    
    it "has the trainer's name" do
      page.should have_css("a", text: @trainer.username.titleize)
    end
    
    it "doesn't have a workout listed until the booking's completed" do
      page.should_not have_content(@booking.workout.title)
    end
    
    it "suggests a new time for the booking before it's completed" do
      click_link("Suggest New Time")
      fill_in "booking_wo_date",   with: "#{1.day.from_now}"
      click_button("Suggest New Time")

      last_email.to.should include(@trainer.email)
      last_email.body.should include(booking_requests_path)
    end
    
    it "allows the client to decline the booking before it's completed" do
      click_button("Decline")
      last_email.to.should include(@trainer.email)
      last_email.body.should include("#{@client.username.titleize} has declined your booking on")
      last_email.body.should include("You can suggest a new time or delete the booking")
    end
  end
end