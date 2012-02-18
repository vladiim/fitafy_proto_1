module UserMacros
  
  def integration_sign_up
    visit root_path
    fill_in "user_username",              with: "test_username"
    fill_in "user_email",                 with: "test_username@email.com"
    fill_in "user_password",              with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button("Sign up free!")
  end
  
  def integration_sign_in(user)
    visit root_path
    fill_in "user_session_username",      with: user.username
    fill_in "user_session_password",      with: user.password
    click_button("Sign in")
  end
  
  def trains_client(trainer, client)
    integration_sign_in(trainer) 
    visit user_path(client)
    click_button("Add Client")
  end
  
  def invite_new_client(trainer, client_email)
    integration_sign_in(trainer)
    click_link("Invite New")
    fill_in "client_email", with: client_email
    click_button("Invite New Client")
  end
end