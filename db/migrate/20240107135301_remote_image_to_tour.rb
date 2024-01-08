class RemoteImageToTour < ActiveRecord::Migration[6.0]
  def change
    remove_column :tours, :image, :string
  end
end
