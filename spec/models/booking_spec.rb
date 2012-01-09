require 'spec_helper'

describe Booking do
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:user)
    @workout = Factory(:workout)
    @date_time = 1.day.from_now
    @booking = @trainer.bookings.create!(:client_id => @client.id, :workout_id => @workout.id)
  end
  
  describe "user associations" do
    
    it "booking trainer should be the trainer" do
      @booking.trainer.should eq(@trainer)
    end
    
    it "booking client should be the client" do
      @booking.client.should eq(@client)
    end
    
    it "booking workout should be the workout" do
      @booking.workout.should eq(@workout)
    end
  end
end
