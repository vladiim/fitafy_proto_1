require 'spec_helper'

describe Booking do
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @workout = Factory(:workout)
    @date_time = 1.day.from_now
    @booking = @trainer.bookings.create!(client_id: @client.id, workout_id: @workout.id, wo_date: 1.week.from_now, wo_time: Time.now, request_from: @trainer.id, last_message_from: @trainer.id)
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
      @attr = { client:       @client,
                wo_date:      :tomorrow,
                wo_time:      Time.now,
                workout:      @workout,
                request_from: @trainer.id,
                booking_length: 30
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

    it "trainer bookings must have a request_from" do
      @trainer.bookings.build(@attr.merge(request_from: nil)).should be_invalid
    end

    it "client bookings must have a request_from" do
      @client.reverse_bookings.build(@attr.merge(trainer_id: @trainer.id, request_from: nil)).should be_invalid
    end

    it "must have a booking_length for a trainer" do
      @trainer.bookings.build(@attr.merge(booking_lenth: nil)).should be_invalid
    end

    it "must have a booking_length for a client" do
      @client.reverse_bookings.build(@attr.merge(trainer_id: @trainer.id, booking_lenth: nil)).should be_invalid
    end
  end

  describe "status" do

    describe "trainer requested booking" do
      
      before(:each) do
        @booking = Factory(:booking, client_id: @client.id, trainer_id: @trainer.id, last_message_from: @trainer.id,)
      end
      
      it "newly created bookings have a trainer_proposed status by default" do
        @booking.status?.should eq("trainer_proposed")
      end

      it "trainer: records who the booking request is from" do
        @trainer.booking_invites.should_not include(@booking)
        @client.booking_invites.should include(@booking)
      end
    end
    
    describe "client requested booking" do
      it "client: records who the booking request is from" do
        @booking = Factory(:client_booking, trainer_id: @trainer.id, client_id: @client.id, last_message_from: @client.id)

        @client.booking_invites.should_not include(@booking)
        @trainer.booking_invites.should include(@booking)
      end
    end
  end
end
