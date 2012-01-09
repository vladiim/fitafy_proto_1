class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :trainer_id
      t.integer :client_id
      t.datetime :date_time
      t.integer :workout_id
      t.string :message

      t.timestamps
    end
    add_index :bookings, :date_time
    add_index :bookings, :trainer_id
    add_index :bookings, :client_id
    add_index :bookings, :workout_id
  end
end
