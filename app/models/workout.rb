class Workout < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user_id, :on => :create, :message => "can't be blank"
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  
  validates :title, :length => { :maximum => 200 }
end
