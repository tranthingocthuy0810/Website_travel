class AddTransportToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :transport, :string
  end
end
