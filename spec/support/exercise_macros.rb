module ExerciseMacros

  def create_exercise(admin)
    integration_sign_in(admin)
    exercise_title = "Dumbell Shoulder Press"
    exercise_description = "Get two dumbells and press!"
    visit new_exercise_path
    fill_in "exercise_title", :with => exercise_title
    fill_in "exercise_description", :with => exercise_description    
    click_button("Create New Exercise")
  end
  
  def new_exercise
    admin = new_admin
    exercise = Factory(:exercise, :user => admin)
    exercise
  end
end