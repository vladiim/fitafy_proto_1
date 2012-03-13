class AddRequestToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :request, :boolean, default: false

  end
end
