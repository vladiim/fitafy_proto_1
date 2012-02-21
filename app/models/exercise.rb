class Exercise < ActiveRecord::Base
  
  attr_accessible :title, :description, :body_part, :equipment, :cues, :booking_id, :user_id
  
  belongs_to :user
  belongs_to :booking
  
  has_and_belongs_to_many :workouts
  
  validates :title, presence: true , 
                    length: { minimum: 4 }
  
  BODY_PARTS = %w[Bicep Chest Legs Shoulder Tricep Back]
  EQUIPMENT = %w[ Dumbbell Chinup-bar Dumbells Bench Barbell Squat-rack Cable-machine Barbell]
  
  def body_parts_symbols
    [body_parts.to_sym]
  end
  
  def equipment_symbols
    [equipment.to_sym]
  end
end

