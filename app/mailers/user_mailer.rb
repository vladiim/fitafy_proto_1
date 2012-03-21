class UserMailer < AsyncMailer
  
  default from: "no_reply@fitafy.com"
  
  if Rails.env.production?
      default_url_options[:host] = "fitafy.com"
  else
    default_url_options[:host] = "localhost:3000"
  end
  
  def password_reset(user)
    @email_link   = edit_password_reset_url(user.perishable_token)
    mail to:        user.email,
         subject:   "fitafy - Password Reset",
         date:      Time.now
  end
  
  def send_new_client_invite(relationship)
    @trainer      = relationship.trainer
    @client       = User.find(relationship.client_id)
    @url          = edit_client_url(@client.perishable_token)
    mail to:        @client.email,
         subject:   "Invite to Join",
         date:      Time.now
  end
  
  def send_exsisting_client_invite(relationship)
    set_relationship_trainer_client_and_url(relationship)

    mail to:        @client.email,
         subject:   "Trainer Invite",
         date:      Time.now
  end
  
  def send_exsisting_trainer_invite(relationship)
    set_relationship_trainer_client_and_url(relationship)

    mail to:        @trainer.email,
         subject:   "Client Invite",
         date:      Time.now
  end
  
  private
  
    def set_relationship_trainer_client_and_url(relationship)
      @trainer      = User.find(relationship.trainer_id)
      @client       = User.find(relationship.client_id)
      @invites_url  = invites_url
    end
end
