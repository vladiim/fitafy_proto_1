class AddBookingLengthToBooking < ActiveRecord::Migration
  def up
    add_column :bookings, :booking_length, :integer, null: false, default: 30
  end

  def down
    remove_column :bookings, :booking_length
  end
end
