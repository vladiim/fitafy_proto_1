module ExerciseMacros

  def create_exercise(admin)
    integration_sign_in(admin)
    visit new_exercise_path
    fill_in "exercise_title", with: "Dumbell Shoulder Press"
    fill_in "exercise_description", with: "Get two dumbells and press!" 
    select("Back", from: "exercise_body_part")
    select("Dumbbells", from: "exercise_equipment")
    fill_in "exercise_cues", with: "You gotta remember to do stuff with this workout yo" 
    click_button("Create New Exercise")
  end
  
  def new_exercise
    admin = new_admin
    exercise = Factory(:exercise, user: admin)
    exercise
  end
end