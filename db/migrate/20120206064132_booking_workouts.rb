class BookingWorkouts < ActiveRecord::Migration
  def up
    remove_column :bookings, :workout_id
    add_column :workouts, :booking_id, :integer
    add_index :workouts, :booking_id
  end

  def down
    remove_index :workouts, :booking_id
    remove_column :workouts, :booking_id
    add_column :bookings, :workout_id, :integer
    add_index :bookings, :workout_id
  end
end
