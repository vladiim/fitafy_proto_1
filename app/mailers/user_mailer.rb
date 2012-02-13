class UserMailer < ActionMailer::Base
  default from: "no_reply@fitafy.com"
  default_url_options[:host] = "localhost:3000"
  
  def password_reset(user)
    @email_link = edit_password_reset_url(user.perishable_token)
    mail to:         user.email,
         subject:    "fitafy - Password Reset",
         date:       Time.now
  end
  
  def client_invitation(invitation, user)
    @signup_url =   edit_invited_client_url(user.perishable_token)
    @trainer    =   User.find(invitation.trainer_id)
    mail to:        invitation.recipient_email,
         subject:   "fitafy Invite From #{@trainer.username}"
         invitation.update_attribute(:sent_at, Time.now) 
  end
end
