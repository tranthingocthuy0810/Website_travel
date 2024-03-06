class AddTripToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :trip, :string
  end
end
