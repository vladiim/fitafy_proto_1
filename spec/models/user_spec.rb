require 'spec_helper'

describe User do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:user)
    @trainer.train!(@client)
  end
  
  describe "trainer and client relationships" do
    
    it "should be training? a trained! @client" do
      @trainer.should be_training(@client)
    end

    it "should not be training? an untrained! client" do
      @trainer.untrain!(@client)
      @trainer.should_not be_training(@client)
    end

    it "clients should be trained_by a trainer" do
      @client.should be_trained_by(@trainer)
    end    
  end
  
  describe "workouts" do
    
    it "should have a workouts attribute" do
      @trainer.should respond_to(:workouts)
    end
    
    it "should destroy a workout if the user is destroyed" do
      @workout = Factory(:workout, :user => @trainer)
      @trainer.destroy
      Workout.find_by_id(@workout.id).should be_nil
    end
  end
  
  describe "exercises" do
    
    it "user should have an exercise attribute" do
      @trainer.should respond_to(:exercises)
    end
    
    it "should only allow admin users to create and update exercises" 
  end
  
  describe "bookings" do
    
    it "should have a bookings method" do
      @trainer.should respond_to(:bookings)
    end
  end
end
