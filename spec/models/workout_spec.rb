require 'spec_helper'

describe Workout do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @exercise = Factory(:exercise)
    @attr = { title:        "Workout 1",
              description:  "Workout Description",
              exercise_ids:  @exercise.id
    }
    @workout = Factory(:workout, user_id: @trainer.id)
  end
  
  describe "template" do
    
    it "should set a newly created workout as a template" do
      @workout.template.should be_true
    end
    
    it "should not set a booking's workout as a template" do
      @booking_workout = Factory(:booking, workout: @workout)
      @booking_workout.workout.template.should_not be_true
    end
  end
  
  describe "associations" do
    
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
        @exercise = Factory(:exercise)
      end
      
      it "should have an exercises attribute" do
        @workout.should respond_to(:exercises)
      end
    end
    
    describe "bookings associations" do
      
      before(:each) do
        @booking = Factory(:booking, workout: @workout, trainer_id: @trainer.id, client_id: @client.id, wo_date: 1.week.from_now)
      end
      
      it "should have a booking attribute" do
        @workout.should respond_to(:booking)
      end
    end
  end
  
  describe "validations" do
    
    it "should require a user_id" do
      Workout.new(@attr).should be_invalid
    end
    
    it "should require a title" do
      @trainer.workouts.build(@attr.merge(title: "")).should be_invalid
    end
    
    it "should have a title under 200 characters long" do
      title = "a" *201
      @trainer.workouts.build(@attr.merge(title: title)).should be_invalid
    end
    
    it "should require an exercise" do
      @trainer.workouts.build(@attr.merge(exercise_ids: nil)).should be_invalid
    end    
  end
end
