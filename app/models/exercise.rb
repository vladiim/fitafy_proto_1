class Exercise < ActiveRecord::Base
  
  attr_accessible :title, :description
  
  belongs_to :user
  
  has_and_belongs_to_many :workouts
  
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :description, :on => :create, :message => "can't be blank"
  
end

