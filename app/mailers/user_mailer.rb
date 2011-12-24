class UserMailer < ActionMailer::Base
  default from: "no_reply@fitafy.com"
  default_url_options[:host] = "localhost:3000"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @email_link = edit_password_reset_url(user.perishable_token)
    sent_on       Time.now
    mail :to        => user.email,
         :subject   => "fitafy - Password Reset"
  end
end
