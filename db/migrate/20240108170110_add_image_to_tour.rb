class AddImageToTour < ActiveRecord::Migration[6.0]
  def change
    add_column(:tours, :image, :string, limit: 500)
  end
end
