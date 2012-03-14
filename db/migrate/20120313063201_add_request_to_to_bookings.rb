class AddRequestToToBookings < ActiveRecord::Migration
  def up
    add_column :bookings, :last_message_from, :integer
  end
  
  def down
    remove_column :bookings, :last_message_from
  end
end
