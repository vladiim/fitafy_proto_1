class AddBodyPartAndCuesToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :body_part, :string
    add_column :exercises, :equipment, :string
    add_column :exercises, :cues, :string
    add_index :exercises, :body_part 
    add_index :exercises, :equipment
  end
end
