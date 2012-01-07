class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :user_id
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :exercises, :user_id
    add_index :exercises, :title
    add_index :exercises, [:user_id, :title]
  end
end
