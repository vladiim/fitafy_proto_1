module ExerciseMacros

  def create_exercise(trainer)
    integration_sign_in(trainer)
    exercise_title = "Dumbell Shoulder Press"
    exercise_description = "Get two dumbells and press!"
    visit root_path
    visit new_exercise_path
    fill_in "exercise_title", :with => exercise_title
    fill_in "exercise_description", :with => exercise_description    
    click_button("Create New Exercise")
  end
end