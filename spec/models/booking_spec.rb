require 'spec_helper'

describe Booking do
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @workout = Factory(:workout)
    @date_time = 1.day.from_now
    @booking = @trainer.bookings.create!(client_id: @client.id, workout: @workout, wo_date: 1.week.from_now)
  end
  
  describe "associations" do
    
    describe "user associations" do

      it "booking trainer should be the trainer" do
        @booking.trainer.should eq(@trainer)
      end

      it "booking client should be the client" do
        @booking.client.should eq(@client)
      end
      
    end
    
    describe "workout associations" do
      
      it "booking workout should be the booking" do
        @booking.workout.id.should eq(@workout.id)
      end
    end
  end
end
