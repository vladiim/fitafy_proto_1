class Relationship < ActiveRecord::Base
  
  attr_accessible :client
  
  belongs_to :trainer, :class_name => "User"
  belongs_to :client, :class_name => "User"
  
  validates_presence_of :trainer_id, :on => :create, :message => "can't be blank"
  validates_presence_of :client_id, :on => :create, :message => "can't be blank"
end
