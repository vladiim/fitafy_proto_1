class ExercisesWorkouts < ActiveRecord::Migration
  def change
    create_table :exercises_workouts, :id => false do |t|
      t.integer :workout_id
      t.integer :exercise_id
    end
  end
end
