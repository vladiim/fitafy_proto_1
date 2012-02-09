class Booking < ActiveRecord::Base
  
  attr_accessible :client_id, :wo_date, :wo_time, :message, :workout
  
  belongs_to :trainer, class_name: "User"
  belongs_to :client, class_name: "User"
  has_one :workout, class_name: "Workout", :foreign_key => "booking_id"
  accepts_nested_attributes_for :workout
  
  validates_presence_of :trainer_id, message: "can't be blank", numericality: { :only_integer => true, :greater_than => 0 }
  validates_presence_of :client_id, :message => "can't be blank", numericality: { :only_integer => true, :greater_than => 0 }
  # validates_presence_of :wo_date, message: "can't be blank"
  validate :wo_date_cannot_be_in_the_past

  def booking_date
    self.wo_date.strftime("%A %e %b") 
  end
  
  def booking_time
    self.wo_time.strftime("%I:%M %p")
  end  
  
  def create_new_workout(workout)
    self.build_workout do |w|
      w.title = workout.title
      w.description = workout.description
      w.exercise_ids = workout.exercise_ids
      w.user = self.trainer
      w.save!
    end
  end
  
  private
  
    def wo_date_cannot_be_in_the_past
      if !wo_date.blank? && wo_date.to_s < Date.today.to_s
        errors.add(:wo_date, "you'll need to either make the booking in the future or give us a ride in your time machine!")
      end
    end
end
