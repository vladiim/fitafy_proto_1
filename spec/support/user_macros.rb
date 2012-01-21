module UserMacros
  
  def integration_sign_up
    visit root_path
    fill_in "user_username", :with => "test_username"
    fill_in "user_email", :with => "test_username@email.com"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_button("Sign up free!")
  end
  
  def integration_sign_in(user)
    visit root_path
    fill_in "user_session_username", :with => user.username
    fill_in "user_session_password", :with => user.password
    click_button("Sign in")
  end
  
  def new_trainer
    trainer = Factory.build(:user)
    trainer.role = "trainer_role"
    trainer.save_without_session_maintenance
    trainer
  end
  
  def new_client
    client = Factory.build(:user) 
    client.role = "client_role"   
    client.save_without_session_maintenance
    client    
  end
  
  def new_admin
    admin = Factory.build(:user)
    admin.save_without_session_maintenance    
    admin.toggle!(:admin)
    admin
  end
end