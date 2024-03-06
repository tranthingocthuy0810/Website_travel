class AddDetailToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :detail, :string, limit: 5000
  end
end
