class ExercisesController < ApplicationController
    
  def index
    @title = "Exercises"
    @exercises = Exercise.all
  end

  def new
    @title = "Create New Exercise"
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(params[:exercise])
    if @exercise.save
      flash[:success] = "New exercise added!"
      redirect_to exercises_path
    else
      render :new
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
    @title = "#{@exercise.title}"
  end

  def edit
    @title = "Update Exercise"
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update_attributes(params[:exercise])
      flash[:success] = "Exercise updated!"
      redirect_to exercise_path(@exercise)
    else
      render :edit
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    flash[:success] = "Exercise deleted"
    redirect_to exercises_path
  end

end
