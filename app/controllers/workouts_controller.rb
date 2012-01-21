class WorkoutsController < ApplicationController
  load_and_authorize_resource :through => :current_user

  def index
    @title = "Workouts"        
    if current_user.workouts.empty?
      redirect_to new_workout_path 
      flash[:message] = "You have no workouts, why not make some?" 
    end
  end
    
  def new
    @title = "Create Workout"
  end
  
  def create
    if @workout.save
      flash[:success] = "New workout added!"
      redirect_to workouts_path
    else
      render :new
    end
  end

  def show
    @title = "#{@workout.title}"
  end

  def edit
    @title = "Edit Workout"
  end

  def update
    if @workout.update_attributes(params[:workout])
      flash[:success] = "Workout updated!"
      redirect_to workout_path(@workout)
    else
      render :edit
    end
  end

  def destroy
    @workout.destroy
    flash[:success] = "Workout deleted"
    redirect_to workouts_path
  end
end