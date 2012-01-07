class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :user_id
      t.string :title, :unique => true
      t.string :description

      t.timestamps
    end
    add_index :workouts, :user_id
    add_index :workouts, :title
    add_index :workouts, [:user_id, :title]
  end
end
