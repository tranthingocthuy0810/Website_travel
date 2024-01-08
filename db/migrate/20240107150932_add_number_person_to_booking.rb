class AddNumberPersonToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :number_person, :integer
  end
end
