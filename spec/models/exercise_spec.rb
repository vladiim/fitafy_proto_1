require 'spec_helper'

describe Exercise do
  before(:each) do
    @trainer = Factory(:user)
    @attr = { title: "Shoulder Press", 
              description: "Push da weight man"
    }
  end
  
  describe "created exercise" do
    
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
    
    describe "associations" do
            
      describe "workout associations" do
        
        before(:each) do
          @workout = Factory(:workout, user: @trainer)
        end
        
        it "should have a workout attribute" do
          @exercise.should respond_to(:workouts)
        end
      end
      
      describe "booking associations" do
        
        it "should belong to booking" do
          @exercise.should respond_to(:booking)
        end
      end
    end
    
    describe "validations" do

      it "should validate the presence of a title" do
        @exercise = @trainer.exercises.build(@attr.merge(title: ""))
        @exercise.should be_invalid
      end
      
      it "should not allow titles equal to or under 3 characters" do
        @exercise = @trainer.exercises.build(@attr.merge(title: "123"))
        @exercise.should be_invalid
      end
      
      it "should validate the presence of a description if there is no booking_id" do
        @exercise = @trainer.exercises.build(@attr.merge(description: ""))
        @exercise.should be_invalid
      end
      
      it "should validate the uniqueness of a description if there is no booking_id" do
        @exercise = Factory(:exercise)
        @exercise_copy = @trainer.exercises.build(@attr.merge(description: @exercise.description))
        @exercise_copy.should be_invalid
      end
      
      it "should allow blank descriptions if there is a booking_id" do
        @booking = Factory(:booking)
        @exercise = @trainer.exercises.build(@attr.merge(description: "", booking_id: @booking.id))
        @exercise.should be_valid
      end
      
      it "should validate the uniqueness of a title if there is no booking_id" do
        @exercise = Factory(:exercise)
        @exercise_copy = @trainer.exercises.build(@attr.merge(title: @exercise.title))
        @exercise_copy.should be_invalid
      end
    end
  end
end
