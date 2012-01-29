require 'spec_helper'

describe "Password Resets" do
  
  before(:each) do
    @trainer = Factory(:user)
  end
  
  it "sends an email with a link to reset the password" do
    forgot_password(@trainer)    
    page.should have_content("Instructions to reset your password have been sent")
    last_email.to.should include(@trainer.email)
  end
  
  # it "lets the user reset their password" do
  #   visit edit_password_reset_path(@trainer)
  #   fill_in "password_reset_password", :with => @trainer.password
  #   fill_in "password_reset_password_confirmation", :with => @trainer.password    
  #   click_button("Reset password")
  #   page.should have_content("Your password has been updated!")
  # end
  # 
  # it "doesn't let users visit the password edit with an incorrect url" do
  #   visit edit_password_reset_path(:perishable_token => "wrongSh1tm0n")
  #   page.should have_content("The url you entered isn't valid, try copy and pasting in out of your email again")
  # end
end