class AddSetsRepsToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :sets, :integer
    add_column :exercises, :reps, :integer
    add_column :exercises, :booking_id, :integer
  end
end
