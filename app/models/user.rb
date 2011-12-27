class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.maintain_sessions = false # reason https://github.com/binarylogic/authlogic/issues/262#issuecomment-1804988
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset(self).deliver
  end
end