class Relationship < ActiveRecord::Base

  attr_accessible :client_id, :trainer_id, :accepted, :declined

  belongs_to :trainer, :class_name => "User"
  belongs_to :client, :class_name => "User"

  validates_presence_of :trainer_id, :on => :create, :message => "can't be blank"
  validates_presence_of :client_id, :on => :create, :message => "can't be blank"

  scope :accepted, where(:accepted => true)
  scope :unaccepted, where(:accepted => false)  

  after_save :destroy_if_declined

  before_destroy :ensure_trainer_client_arent_same

  def send_client_invite
    find_trainer_and_client

    unless @client == @trainer
      send_new_client_email(@client)
    end
  end

  def send_trainer_invite
    UserMailer.send_exsisting_trainer_invite(self).deliver
  end

  def sent_from!(user_id)
    self.sent_from = user_id
    save!
  end

  def sender
    if trainer_id == sent_from
      User.find(trainer_id)
    else
      User.find(client_id)
    end
  end

  protected

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

    def find_trainer_and_client
      @trainer = User.find(self.trainer_id)
      @client = User.find(self.client_id)
    end

    def ensure_trainer_client_arent_same
      self.trainer_id != self.client_id
    end
end