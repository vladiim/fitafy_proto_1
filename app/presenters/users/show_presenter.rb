class Users::ShowPresenter
  
  def initialize(current_user, show_user_id)
    @current_user = current_user
    @user = User.find(show_user_id)
    @admins = User.find_all_by_admin(true)
    @admin = @admins.first
  end
  
  def title
    @title = @user.username.titleize
  end
  
  def current_user
    @current_user
  end
  
  def user
    @user
  end
  
  def relationship
    @relationship = @current_user.relationships.find_by_client_id(@user.id)
  end
  
  def client
    @client = Client.new
  end
  
  def workouts
    if @user.workouts.empty?
      @admin.workouts
    else
      @user.workouts
    end
  end
  
  def exercises
    if @user.exercises.empty?
      @admin.exercises
    else
      @user.exercises
    end
  end
  
  def training_count
    if @user.training.count >= 5
      @training_count = 5
    else
      @training_count = @user.training.count
    end
  end
  
  def booking_count
    if @user.bookings.count >= 5
      @booking_count = 5
    else
      @booking_count = @user.training.count
    end
  end
  
  def workouts_count
    if @user.workouts.count >= 5
      @workouts_count = 5
    else
      @workouts_count = @user.workouts.count
    end
  end
  
  def exercises_count
    if @user.exercises.count >= 5
      @exercises_count = 5
    else
      @exericses_count = @user.exercises.count
    end
  end
  
  def user_and_admin_workouts
    @workouts = @user.workouts if @user.workouts
    @workouts << @admin.workouts
  end
  
  def user_and_admin_exercises
    @workouts = @user.exercises if @user.exercises
    @workouts << @admin.exercises
  end
  
  def user_client_bookings(trainer, client)
    Booking.where(trainer_id: trainer.id).where(client_id: client.id)
  end
  
  def trainer_first
    # trainers = @user.trained_by
    trainers
    trainers[0]
  end
  
  def trainers
    trainers = @user.trained_by
  end
  
  def trainer_username(trainer)
    trainer.username
  end
end