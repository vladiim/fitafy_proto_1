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
  
  after_create :checks_if_created_by_admin

  BODY_PARTS = ["Abdominals", "Back", "Biceps", "Chest", "Legs", "Lower back", "Shoulders", "Tricep"]
  EQUIPMENT = ["45 degree Leg Press machine", "BOSU", "BOSU and Cables", "Barbell", "Barbell or Dumbbell", "Bench, Chair", "Bench, chair", "Cable machine", "Cables", "Chest Press Machine", "Dual Cable Machine", "Dumbbell", "Dumbbells", "Dumbbells Optional", "EZ bar", "EZ bar, Preacher bench", "EZY Bar", "Elastic Band", "Elastic band", "Hack Squat machine", "Lat pulldown machine", "Leg Extension machine ", "Leg curl machine", "Low cable row", "Parallel Bars", "Pull Bar", "Pulldown machine", "Swiss Ball", "Swiss ball", "Swiss ball, Dumbbells", "Wall", "barbell", "cable cross over machine", "dumbbell", "dumbbells", "dumbell, swissball", "dumbells, Barbell optional", "dumbells, flyes", "elastic band", "low cable row, Wide bar", "parallel bars", "roman chair", "swiss ball"]
  
  def body_parts_symbols
    [body_parts.to_sym]
  end
  
  def equipment_symbols
    [equipment.to_sym]
  end
  
  def current_user_workouts(current_user, count=false)
    if count
      workouts.where(user_id: current_user.id).count
    else
      workouts.where(user_id: current_user.id)
    end
  end
  
  private
    
    def no_booking_id
      !self.booking_id.present?
    end
    
    def checks_if_created_by_admin
      user = User.find(self.user_id)
      self.toggle!(:admin) if user.admin?
    end
end
