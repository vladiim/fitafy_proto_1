module WorkoutMacros
  
  def new_workout(trainer, exercise)
    integration_sign_in(trainer)
    visit new_workout_path
    fill_in"workout_title", :with => "Workout Title"
    fill_in"workout_description", :with => "Workout Description"
    check("workout_exercise_ids_")
    click_button("Create Workout")
  end
end