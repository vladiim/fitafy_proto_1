require 'spec_helper'

describe User do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @trainer.train!(@client)
  end

  describe "when a trainer is created" do
    
    it "trainer should automatically train themself" do
      @trainer.training.should include(@trainer)
    end
    
    it "should automatically accept the invite to train themself" do
      @my_relationship = @trainer.relationships.where(client_id: @trainer.id)
      @my_relationship.first.accepted.should eq(true)
    end
    
    it "shouln't send the invite email" do
      @new_trainer = Factory(:user)
      last_email.body.should_not include("#{@new_trainer.username.titleize} wants to train you")
    end
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
      @workout = Factory(:workout, user: @trainer)
      @trainer.destroy
      Workout.find_by_id(@workout.id).should be_nil
    end
  end
  
  describe "exercises" do
    
    it "user should have an exercise attribute" do
      @trainer.should respond_to(:exercises)
    end
    
  end
  
  describe "bookings" do
    
    it "should have a bookings method for trainers" do
      @trainer.should respond_to(:bookings)
    end
    
    it "should have a reverse_bookings method for clients" do
      @client.should respond_to(:reverse_bookings)
    end
    
  end
  
  describe "roles" do
    
    it "should have an admin attribute" do
      @trainer.should respond_to(:admin)
    end
    
    it "should default admin to false" do
      @trainer.should_not be_admin
    end
    
    it "should be able to change the user's admin status with toggle" do
      @trainer.toggle!(:admin)
      @trainer.should be_admin
    end
  end
end
