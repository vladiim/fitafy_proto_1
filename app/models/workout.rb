class Workout < ActiveRecord::Base
  
  attr_accessible :title, :description, :exercise_ids
  
  belongs_to :user
  
  has_and_belongs_to_many :exercises
  
  has_many :bookings
  
  validates_presence_of :user_id, :title, :exercise_ids
  
  validates :title, length: { :maximum => 200 },
                    uniqueness: { case_sensitive: false }
  
  before_create :strip_empty_exercise_ids
  
  def trainer_bookings_with_workout_title(current_user, count=false)
    if count
      bookings.where(trainer_id: current_user.id).count
    else
      bookings.where(trainer_id: current_user.id)
    end
  end
  
  private
  
    def strip_empty_exercise_ids
      @exercise_ids = exercise_ids.delete_if { |id| id == "" }
    end
end
