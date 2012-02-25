class WorkoutsController < ApplicationController
  load_and_authorize_resource :through => :current_user, except: [:new, :edit]

  def index
    @title = "Workouts"        
    if current_user.workouts.empty?
      redirect_to new_workout_path 
      flash[:message] = "You have no workouts, why not make some?" 
    end
  end
    
  def new
    @presenter = Exercises::ChildPresenter.new("Create Workout", "workout", nil, current_user)
  end
  
  def create
    if @workout.save
      flash[:success] = "New workout added!"
      redirect_to workout_path(@workout)
    else
      render :new
    end
  end

  def show
    @title = "#{@workout.title}"
    @exercises = @workout.exercises.all
  end

  def edit
    @presenter = Exercises::ChildPresenter.new("Edit Workout", "workout", params[:id], current_user)
  end

  def update
    params[:workout][:exercise_ids] ||= []
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