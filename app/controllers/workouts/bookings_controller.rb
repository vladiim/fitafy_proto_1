class Workouts::BookingsController < ApplicationController
  
  def index
    @workout = Workout.find(params[:workout_id])
    @bookings = @workout.bookings
    @title = "#{@workout.title} Bookings"    
  end
  
end