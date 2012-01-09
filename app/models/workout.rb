class Workout < ActiveRecord::Base
  belongs_to :user
  
  has_and_belongs_to_many :exercises
  accepts_nested_attributes_for :exercises
  
  has_many :bookings, :foreign_key => "workout_id"
  
  validates_presence_of :user_id, :on => :create, :message => "can't be blank"
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  
  validates :title, :length => { :maximum => 200 }
end
