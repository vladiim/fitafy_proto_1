module UserMacros
  
  def integration_sign_up
    visit signup_path
    fill_in "user_username",              with: "test_username"
    fill_in "user_email",                 with: "test_username@email.com"
    fill_in "user_password",              with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button("Sign Up")
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
    click_link("Create Booking")
    click_link("Invite New")
    fill_in "client_email", with: client_email
    click_button("Invite New Client")
  end
  
  def forgot_password(user)
    visit root_path
    click_link("Forgot password?")
    fill_in "forgot_password_link_email", with: user.email
    click_button("Reset Password")
  end

  def sign_in_accept_relationship(user)
    integration_sign_in(user)
    accept_relationship
  end

  def sign_in_decline_relationship(user)
    integration_sign_in(user)
    decline_relationship
  end

  def accept_relationship
    visit invitations_path
    check('relationship_accepted')
    click_button("Save")
  end

  def decline_relationship
    visit invitations_path
    check('relationship_declined')
    click_button("Save")
  end
end