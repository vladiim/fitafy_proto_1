class ChangeBookingsInstructions < ActiveRecord::Migration
  change_table :bookings do |t|
    t.remove :instructions
    t.text :instructions, default: "No workout insructions"
  end
end
