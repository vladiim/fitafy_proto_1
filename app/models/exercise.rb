class Exercise < ActiveRecord::Base
  
  attr_accessible :title, :description, :body_part, :equipment, :cues
  
  belongs_to :user
  
  has_and_belongs_to_many :workouts
  
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :description, :on => :create, :message => "can't be blank"
  
  BODY_PARTS = %w[Bicep Chest Legs Shoulder Tricep Back]
  EQUIPMENT = %w[ Dumbbell Chinup-bar Dumbells Bench Barbell Squat-rack Cable-machine Barbell]
  
  def body_parts_symbols
    [body_parts.to_sym]
  end
  
  def equipment_symbols
    [equipment.to_sym]
  end
end

