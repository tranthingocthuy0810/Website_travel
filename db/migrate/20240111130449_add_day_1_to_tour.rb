class AddDay1ToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :day1, :string, limit: 3000
  end
end
