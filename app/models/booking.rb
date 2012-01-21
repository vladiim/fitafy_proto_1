class Booking < ActiveRecord::Base
  
  attr_accessible :client_id, :wo_date, :wo_time, :workout_id, :message
  
  belongs_to :trainer, :class_name => "User"
  belongs_to :client, :class_name => "User"
  belongs_to :workout, :class_name => "Workout", :foreign_key => "workout_id"
  
  validates_presence_of :trainer_id, :on => :create, :message => "can't be blank", :numericality => { :only_integer => true, :greater_than => 0 }
  validates_presence_of :client_id, :on => :create, :message => "can't be blank", :numericality => { :only_integer => true, :greater_than => 0 }
  validates_presence_of :wo_date, :on => :create, :message => "can't be blank"

  def booking_date
    self.wo_date.strftime("%A %e %b")
  end
  
  def booking_time
    self.wo_time.strftime("%I:%M %p")
  end  
end
