class User < ActiveRecord::Base
  acts_as_authentic 
  
  has_many :relationships, :foreign_key => "trainer_id", :dependent => :destroy
  has_many :training, :through => :relationships, :source => :client
  
  has_many :reverse_relationships, :class_name => "Relationship", :foreign_key => "client_id", :dependent => :destroy
  has_many :trained_by, :through => :reverse_relationships, :source => :trainer
  
  has_many :workouts, :dependent => :destroy
  
  has_many :exercises, :dependent => :destroy
  
  has_many :bookings, :foreign_key => "trainer_id"
    
  def train!(client)
    relationships.create!(:client_id => client.id)
  end
  
  def untrain!(client)
    relationships.find_by_client_id(client).destroy
  end
  
  def training?(client)
    relationships.find_by_client_id(client)
  end
  
  def trained_by?(trainer)
    reverse_relationships.find_by_trainer_id(trainer)
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset(self).deliver
  end
    
end