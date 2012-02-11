class UserMailer < ActionMailer::Base
  default from: "no_reply@fitafy.com"
  default_url_options[:host] = "localhost:3000"
  
  def password_reset(user)
    @email_link = edit_password_reset_url(user.perishable_token)
    mail to:         user.email,
         subject:    "fitafy - Password Reset",
         date:       Time.now
  end
  
  def client_invitation(invitation)
    @signup_url =   "http://localhost:3000/signup/#{invitation.token}"
    @trainer    =   User.find(invitation.trainer_id)
    mail to:        invitation.recipient_email,
         subject:   "fitafy Invite From #{@trainer.username}"
         invitation.update_attribute(:sent_at, Time.now) 
  end
end
