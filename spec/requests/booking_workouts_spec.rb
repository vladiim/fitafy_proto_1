require 'spec_helper'

describe "BookingWorkouts" do
  
  before(:each) do
    @trainer = Factory(:user)
    @client = Factory(:client)
    @trainer.train!(@client)
    @workout = Factory(:workout, user_id: @trainer.id)
  end
  
  it "creates a new workout when a new booking is made" do
    first_workout_count = @trainer.workouts.count
    sign_in_and_create_booking(@trainer, @client, @workout)
    @trainer.workouts.count.should > first_workout_count
  end
end
