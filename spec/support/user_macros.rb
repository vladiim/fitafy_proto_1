module UserMacros
  
  def integration_sign_up(user)
    visit root_path
    fill_in "user_username", :with => user.username
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password    
    fill_in "user_password_confirmation", :with => user.password
    click_button("Sign up free!")
  end
  
  def integration_sign_in(user)
    visit root_path
    fill_in "user_session_username", :with => user.username
    fill_in "user_session_password", :with => user.password
    click_button("Sign in")
  end
  
end