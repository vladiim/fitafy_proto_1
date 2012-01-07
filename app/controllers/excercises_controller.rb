class ExercisesController < ApplicationController
  
  def index
  end

  def new
    @title = "New Exercise"
    @exercise = current_user.exercises.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
