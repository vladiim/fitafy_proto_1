class Workout < ActiveRecord::Base
  
  attr_accessible :title, :description, :exercise_ids
  
  belongs_to :user
  
  has_and_belongs_to_many :exercises
  
  has_many :bookings
  
  validates_presence_of :user_id, :title, :exercise_ids
  
  validates :title, :length => { :maximum => 200 }
  
end
