class AddDay2ToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :day2, :string, limit: 3000
  end
end
