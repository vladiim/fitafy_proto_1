class ExercisesController < ApplicationController
  load_and_authorize_resource except: :index
  respond_to :html, :json

  def index
    @title = "Exercises"
    @exercises = current_user.exercise_list.paginate(:page => params[:page], :per_page => 10)
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
    respond_with @exercise
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
