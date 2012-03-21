class Exercises::WorkoutsController < ApplicationController
  
  def index
    @exercise = Exercise.find(params[:exercise_id])
    @workouts = @exercise.current_user_workouts(current_user)
    @title = "#{@exercise.title} Workouts"
  end
end