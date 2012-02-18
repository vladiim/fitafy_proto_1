class UserMailer < ActionMailer::Base
  default from: "no_reply@fitafy.com"
  default_url_options[:host] = "localhost:3000"
  
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
         subject:   "Invite to Join"
  end
  
  def send_exsisting_client_invite(relationship)
    @trainer      = relationship.trainer
    @client       = User.find(relationship.client_id)
    @invites_url  = invites_path
    mail to:        @client.email,
         subject:   "Trainer Invite"
  end  
end
