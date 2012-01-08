require 'spec_helper'

describe Exercise do
  before(:each) do
    @trainer = Factory.build(:user)
    @trainer.save_without_session_maintenance
    @attr = { :title => "Shoulder Press", 
              :description => "Push da weight man"
    }
  end
  
  describe "associations" do
    
    before(:each) do
      @exercise = @trainer.exercises.create(@attr)
    end
    
    describe "user associations" do

      it "should have a user attribute" do
        @exercise.should respond_to(:user)
      end

      it "should have the right user associations" do
        @exercise.user_id.should eq(@trainer.id)
        @exercise.user.should eq(@trainer)
      end
    end
    
    describe "workout associations" do
      
      before(:each) do
        @workout = Factory(:workout, :user_id => @trainer.id)
      end
      
      it "should have a workout attribute" do
        @exercise.should respond_to(:workouts)
      end
    end
  end    
  
  describe "validations" do
    
    it "should validate the presence of a title" do
      @exercise = @trainer.exercises.create(@attr.merge(:title => ""))
      @exercise.should be_invalid
    end
    
    it "should validate the presence of a description" do
      @exercise = @trainer.exercises.create(@attr.merge(:description => ""))
      @exercise.should be_invalid
    end
  end
end
