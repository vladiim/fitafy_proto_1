require 'spec_helper'

describe Booking do
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @workout = Factory(:workout)
    @date_time = 1.day.from_now
    @booking = @trainer.bookings.create!(client_id: @client.id, workout_id: @workout.id, wo_date: 1.week.from_now, wo_time: Time.now)
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
    
    describe "exercise associations" do
      
      it "should have many exercises" do
        @booking.should respond_to(:exercises)        
      end
    end
  end
  
  describe "validations" do
    
    before(:each) do
      @attr = { client:      @client,
                wo_date:     :tomorrow,
                wo_time:     Time.now,
                workout:     @workout
      }
    end
    
    it "booking must have a trainer_id" do
      Booking.create(@attr).should be_invalid
    end
    
    it "booking must have a date" do
      @trainer.bookings.build(@attr.merge(wo_date: "")).should be_invalid
    end
    
    it "doesn't allow bookings in the past" do
      @trainer.bookings.build(@attr.merge(wo_date: 1.day.ago)).should be_invalid
    end
    
    it "booking must have a time" do
      @trainer.bookings.build(@attr.merge(wo_time: "")).should be_invalid
    end
    
    it "booking must have a client" do
      @trainer.bookings.build(@attr.merge(client: nil)).should be_invalid
    end
    
    it "booking must have a workout" do
      @trainer.bookings.build(@attr.merge(workout: nil)).should be_invalid
    end
  end
end
