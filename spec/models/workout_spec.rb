require 'spec_helper'

describe Workout do
  
  before(:each) do
    @trainer = Factory(:user)
    @attr = { :title => "Workout 1",
              :description => "Workout Description"
    }
  end
  
  describe "user associations" do
    
    before(:each) do
      @workout = @trainer.workouts.create(@attr)
    end
    
    it "workouts should respond to the user attribute" do
      @workout.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @workout.user_id.should eq(@trainer.id)
      @workout.user.should eq(@trainer)
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
