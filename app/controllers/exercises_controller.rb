class ExercisesController < ApplicationController
  load_and_authorize_resource except: :index
    
  def index
    # @exercises = Exercise.templates.where("admin = true or user_id = ?", current_user.id)
    @exercises = current_user.exercise_list
    @title = "Exercises"
  end

  def new
    @title = "Create New Exercise"
  end

  def create
    if @exercise.save
      flash[:success] = "New exercise added!"
      redirect_to exercise_path(@exercise)
    else
      render :new
    end
  end

  def show
    @title = "#{@exercise.title.titleize}"
  end

  def edit
    @title = "Update Exercise"
  end

  def update
    if @exercise.update_attributes(params[:exercise])
      flash[:success] = "Exercise updated!"
      redirect_to exercise_path(@exercise)
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    flash[:success] = "Exercise deleted"
    redirect_to exercises_path
  end
end
