class RemoveBookingFromWorkoutAndAddWorkoutToBooking < ActiveRecord::Migration
  def up
    add_column :bookings, :workout_id, :integer
    remove_column :workouts, :booking_id
    remove_column :workouts, :template
  end

  def down
    add_column :workouts, :template, :boolean
    add_column :workouts, :booking_id, :integer
    remove_column :bookings, :workout_id
  end
end
