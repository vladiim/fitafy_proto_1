class AddStatusToBookings < ActiveRecord::Migration
  def up
    add_column :bookings, :status, :string, default: "trainer_proposed"
    remove_column :bookings, :request
  end
  
  def down
    remove_column :bookings, :status
    add_column :bookings, :request, :boolean, default: false
  end
end
