class Relationship < ActiveRecord::Base
  
  attr_accessible :client_id, :accepted, :declined
  
  belongs_to :trainer, :class_name => "User"
  belongs_to :client, :class_name => "User"
  
  validates_presence_of :trainer_id, :on => :create, :message => "can't be blank"
  validates_presence_of :client_id, :on => :create, :message => "can't be blank"
  
  scope :accepted, where(:accepted => true)
  scope :unaccepted, where(:accepted => false)  
  
  after_create :send_client_invite
  after_save :destroy_if_declined
  
  protected
  
    def send_client_invite
      client = User.find(self.client_id)
      trainer = User.find(self.trainer_id)
      unless client == trainer
        send_new_client_email(client)
      end
    end
    
    def send_new_client_email(client)
      if client.username == client.email
        UserMailer.send_new_client_invite(self).deliver
      else
        UserMailer.send_exsisting_client_invite(self).deliver
      end
    end
    
    def destroy_if_declined
      destroy if declined
    end
end
