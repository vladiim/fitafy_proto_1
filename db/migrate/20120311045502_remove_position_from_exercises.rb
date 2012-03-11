class RemovePositionFromExercises < ActiveRecord::Migration
  def up
    remove_column :exercises, :position
  end

  def down
    add_column :exercises, :position, :integer
  end
end
