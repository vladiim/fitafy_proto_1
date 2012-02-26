class ChangeExerciseSetsReps < ActiveRecord::Migration
  def up
    remove_column :exercises, :sets
    remove_column :exercises, :reps
    add_column :exercises, :sets, :integer, default: 0
    add_column :exercises, :reps, :integer, default: 0
  end

  def down
    remove_column :exercises, :sets
    remove_column :exercises, :reps
    add_column :exercises, :sets, :integer
    add_column :exercises, :reps, :integer
  end
end
