class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.maintain_sessions = true
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset(self).deliver
  end
  
end