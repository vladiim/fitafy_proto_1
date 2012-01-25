class Exercises::WorkoutsController < ApplicationController
  
  def index
    @exercise = Exercise.find(params[:exercise_id])
    @workouts = @exercise.workouts
    @title = "#{@exercise.title} Workouts"    
  end
  
end