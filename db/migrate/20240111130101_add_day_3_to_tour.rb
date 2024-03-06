class AddDay3ToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :day3, :string, limit: 3000
  end
end
