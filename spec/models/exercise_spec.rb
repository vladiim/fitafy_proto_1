require 'spec_helper'

describe Exercise do
  before(:each) do
    @trainer = Factory.build(:user)
    @trainer.save_without_session_maintenance
    @attr = { :title => "Shoulder Press", 
              :description => "Push da weight man"
    }
  end
  
  describe "user associations" do
    
    before(:each) do
      @exercise = @trainer.exercises.create(@attr)
    end
    
    it "should have a user attribute" do
      @exercise.should respond_to(:user)
    end
    
    it "should have the right user associations" do
      @exercise.user_id.should eq(@trainer.id)
      @exercise.user.should eq(@trainer)
    end
  end
  
end
