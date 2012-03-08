class AddInstructionsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :instructions, :text

  end
end
