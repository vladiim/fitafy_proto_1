class ChangeWorkoutsDescriptionToInstructions < ActiveRecord::Migration
  change_table :workouts do |t|
    t.rename :description, :instructions
  end
end
