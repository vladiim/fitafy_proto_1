class User < ActiveRecord::Base
  acts_as_authentic 

  attr_accessible :username, :email, :password, :password_confirmation, :role

  has_many :relationships, :foreign_key => "trainer_id", dependent: :destroy
  has_many :training, through: :relationships, source: :client

  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "client_id", dependent: :destroy
  has_many :trained_by, through: :reverse_relationships, source: :trainer

  has_many :workouts, dependent: :destroy

  has_many :exercises, :dependent => :destroy

  has_many :bookings, :foreign_key => "trainer_id"
  has_many :reverse_bookings, class_name: "Booking", foreign_key: "client_id"

  before_create :set_trainer_role
  before_update :set_client_role

  ROLES = %w[trainer_role client_role invited_role]
   
  def train!(client)
    relationship = relationships.build(client_id: client.id)
    relationship.accepted = true if client.id == self.id
    relationship.save!
    relationship.send_client_invite
  end
  
  def get_trained!(trainer)
    relationship = reverse_relationships.build(trainer_id: trainer.id)
    relationship.save!
    relationship.send_trainer_invite
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
  
  def trainer?
    self.role == "trainer_role"
  end
  
  def trainer
    trainer_id = self.trained_by.first.id
    @trainer = User.find(trainer_id)
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset(self).deliver
  end
  
  def exercise_list
    Exercise.templates.where("admin = ? or user_id = ?", true, self.id)
  end
  
  def alphabetical_workouts
    workouts.order("title")
  end
  
  def role_symbols
    [role.to_sym]
  end
  
  def completed_reverse_bookings
    self.reverse_bookings.where(status: "completed")
  end

  def booking_invites
    if role == "client_role"
      reverse_bookings.find(:all, conditions: ["status = ? AND last_message_from != ?", 'trainer_proposed', self.id])
    else
      bookings.find(:all, conditions: ["status = ? AND last_message_from != ?", 'client_proposed', self.id])
    end
  end



  private

    def set_trainer_role
      self.role = "trainer_role" if self.role == nil
    end
    
    def set_client_role
      self.role = "client_role" if self.role == "invited_role"
    end
end