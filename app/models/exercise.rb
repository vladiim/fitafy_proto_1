class Exercise < ActiveRecord::Base

  attr_accessible :title, :description, :body_part, :equipment, :cues, :booking_id, :user_id, :sets, :reps

  belongs_to :user
  belongs_to :booking

  has_and_belongs_to_many :workouts

  validates :title, presence: true,
                    length: { minimum: 4 }

  validates :description, presence: true,
                          uniqueness: { case_sensitive: false },
                          if: :no_booking_id

  validates :title, uniqueness: { case_sensitive: false }, 
                    if: :no_booking_id

  validates_numericality_of :sets, greater_than_or_equal_to: 0

  validates_numericality_of :reps, greater_than_or_equal_to: 0

  scope :templates, where(booking_id: nil)
  
  before_create :checks_if_created_by_admin

  BODY_PARTS = %w[Bicep Chest Legs Shoulder Tricep Back]
  EQUIPMENT = %w[ Dumbbell Chinup-bar Dumbells Bench Barbell Squat-rack Cable-machine Barbell]
  
  def body_parts_symbols
    [body_parts.to_sym]
  end
  
  def equipment_symbols
    [equipment.to_sym]
  end
  
  private
    
    def no_booking_id
      !self.booking_id.present?
    end
    
    def checks_if_created_by_admin
      user = User.find(self.user_id)
      self.admin = true if user.admin?
    end
end
