class WorkoutsController < ApplicationController

  def index
    @title = "Workouts"    
    @workouts = current_user.workouts.paginate(:page => params[:page], :per_page => 10)
  end
    
  def new
    @title = "Create Workout"
    @workout = current_user.workouts.new
  end
  
  def create
    @workout = current_user.workouts.create!(params[:workout])
    if @workout.save
      flash[:success] = "New workout added!"
      redirect_to workouts_path
    else
      render :new
    end
  end

  def show
    @workout = current_user.workouts.find(params[:id])
    @title = "#{@workout.title}"
  end

  def edit
    @title = "Edit Workout"
    @workout = current_user.workouts.find(params[:id])
  end

  def update
    @workout = current_user.workouts.find(params[:id])
    if @workout.update_attributes(params[:workout])
      flash[:success] = "Workout updated!"
      redirect_to workout_path(@workout)
    else
      render :edit
    end
  end

  def destroy
    @workout = current_user.workouts.find(params[:id])
    @workout.destroy
    flash[:success] = "Workout deleted"
    redirect_to workouts_path
  end
end
