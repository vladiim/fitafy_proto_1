class AddRequestToToBookings < ActiveRecord::Migration
  def up
    add_column :bookings, :request_from, :integer
  end
  
  def down
    remove_column :bookings, :request_from
  end
end
