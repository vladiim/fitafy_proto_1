class Booking < ActiveRecord::Base
  
  attr_accessible :client_id, :wo_date, :wo_time, :message, :exercises, 
                  :trainer, :trainer_id, :client, :workout_id, :instructions, 
                  :status, :request_from
  
  belongs_to :trainer, class_name: "User"
  belongs_to :client, class_name: "User"
  belongs_to :workout
  
  has_many :exercises
  
  validates_presence_of :trainer_id, message: "can't be blank", numericality: { :only_integer => true, :greater_than => 0 }
  validates_presence_of :client_id, message: "can't be blank", numericality: { :only_integer => true, :greater_than => 0 }
  
  validates_presence_of :wo_date, :wo_time, :request_from
  
  validates_presence_of :workout_id, :if => :created_by_trainer
  
  validate :wo_date_cannot_be_in_the_past
  
  after_create :create_exercises_and_instructions, :if => :created_by_trainer
  # after_create :send_create_request
  # after_update :send_update_request
  
  default_scope order(:wo_time).order(:wo_date)

  STATUS = %w[ trainer_proposed client_proposed revised_time confirmed declined completed ]

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

  def status_symbols
    [status.to_sym]
  end
  
  def status?
    @status = self.status
  end
  
  def workout_title
    workout = Workout.find(self.workout_id)
    @workout_title = workout.title
  end
  
  def sender
    # sender is in reference to booking request
    @sender = User.find(self.request_from)
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
    
    def created_by_trainer
      status == "trainer_proposed"
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
    
    # def send_create_request
    #   request_sender = find_sender
    #   request_receiver = find_receiver_based_on_sender(request_sender)
    #   BookingMailer.request_booking_create(request_sender, request_receiver).deliver
    # end
    # 
    # def send_update_request
    #   if self.status == "confirmed"
    #     send_request_confirmed
    #   elsif self.status == "declined"
    #     # send_request_delined
    #   elsif self.status == "revised_time"
    #     # send_request_revised_time
    #   else
    #     # log error
    #   end
    # end
    # 
    # def send_request_confirmed
    #   original_sender = find_sender
    #   original_receiver = find_receiver_based_on_sender(original_sender)
    #   self.sender = original_receiver.id
    #   self.save!
    #   receiver = original_sender
    #   BookingMailer.request_booking_confirmed(sender, receiver, self).deliver
    # end
    # 
    # def find_sender
    #   @sender = User.find(self.request_from)
    # end
    # 
    # def find_receiver_based_on_sender(request_sender)
    #   if self.trainer_id == request_sender.id
    #     receiver = User.find(self.client_id)
    #   elsif self.client_id == request_sender.id
    #     receiver = User.find(self.trainer_id)
    #   else
    #     puts "we got a problem yo"
    #   end
    # end
end
