class AddImageForTour < ActiveRecord::Migration[5.2]
  def change
    add_column(:tours, :image, :string, limit: 500)
  end
end
