module MailerMacros
  
  def last_email
    ActionMailer::Base.deliveries.last
  end
  
  def reset_email
    ActionMailer::Base.deliveries = []
  end
  
  def forgot_password(user)
    visit root_path
    click_link("Forgot password?")
    fill_in "forgot_password_link_email", :with => @trainer.email
    click_button("Update password")
  end
end