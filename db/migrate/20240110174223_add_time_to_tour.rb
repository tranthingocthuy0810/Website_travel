class AddTimeToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :time, :string
  end
end
