class AddTemplateToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :template, :boolean, default: true

  end
end
