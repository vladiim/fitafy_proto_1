require 'spec_helper'

describe Workout do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:user)
    @attr = { :title => "Workout 1",
              :description => "Workout Description"
    }
  end
  
  describe "associations" do
    
    before(:each) do
      @workout = @trainer.workouts.create(@attr)
    end
    
    describe "user associations" do
    
      it "workouts should respond to the user attribute" do
        @workout.should respond_to(:user)
      end
    
      it "should have the right associated user" do
        @workout.user_id.should eq(@trainer.id)
        @workout.user.should eq(@trainer)
      end
    end
  
    describe "exercise associations" do
      
      before(:each) do
        @exercise = Factory(:exercise, :user_id => @trainer.id)
      end
      
      it "should have an exercises attribute" do
        @workout.should respond_to(:exercises)
      end
    end
    
    describe "bookings associations" do
      
      before(:each) do
        @booking = Factory(:booking, :trainer_id => @trainer.id, :client_id => @client.id)
      end
      
      it "should have a booking attribute" do
        @workout.should respond_to(:bookings)
      end
    end
  end
  
  describe "validations" do
    
    it "should require a user_id" do
      Workout.new(@attr).should be_invalid
    end
    
    it "should require a title" do
      @trainer.workouts.build(@attr.merge(:title => "")).should be_invalid
    end
    
    it "should have a title under 200 characters long" do
      title = "a" *201
      @trainer.workouts.build(@attr.merge(:title => title)).should be_invalid
    end
  end
end
