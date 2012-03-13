class Booking < ActiveRecord::Base
  
  attr_accessible :client_id, :wo_date, :wo_time, :message, :exercises, :trainer, :trainer_id, :client, :workout_id, :instructions, :request
  
  belongs_to :trainer, class_name: "User"
  belongs_to :client, class_name: "User"
  belongs_to :workout
  
  has_many :exercises
  
  validates_presence_of :trainer_id, message: "can't be blank", numericality: { :only_integer => true, :greater_than => 0 }
  validates_presence_of :client_id, message: "can't be blank", numericality: { :only_integer => true, :greater_than => 0 }
  
  validates_presence_of :wo_date, :wo_time
  
  validates_presence_of :workout_id, :if => :not_booking_request
  
  validate :wo_date_cannot_be_in_the_past
  
  after_create :create_exercises_and_instructions, :if => :not_booking_request
  
  default_scope order(:wo_time).order(:wo_date)

  def booking_date
    self.wo_date.strftime("%A %e %b") 
  end
  
  def booking_time
    self.wo_time.strftime("%I:%M %p")
  end  
  
  def add_exercises(exercise_ids)
    @trainer = User.find(self.trainer_id)
    @exercise_ids = exercise_ids.delete_if { |id| id == "" }
    @exercise_ids.each do |id|
      exercise = Exercise.find(id)
      self.exercises.create!(user_id: @trainer.id,
                             title: exercise.title)
    end
  end
  
  private
  
    def wo_date_cannot_be_in_the_past
      if !wo_date.blank? && wo_date.to_s < Date.today.to_s
        errors.add(:wo_date, "you'll need to either make the booking in the future or give us a ride in your time machine!")
      end
    end
    
    def create_exercises_and_instructions
      @workout = Workout.find(self.workout_id)
      @trainer = User.find(self.trainer_id)
      create_exercises!(@workout, @trainer)
      create_instructions!(@workout)
    end

    def create_exercises!(workout, trainer)
      @workout.exercises.each do |e|
        self.exercises.create!(user_id: @trainer.id,
                               title: e.title)
      end
    end
    
    def create_instructions!(workout)
      self.instructions = workout.instructions
      save!
    end
    
    def not_booking_request
      request == false
    end
    
    def request!(value)
      request = value
    end
    
    def set_client_id!(id)
      client_id = id
    end
    
    def set_trainer_id!(id)
      trainer_id = id
    end
end
