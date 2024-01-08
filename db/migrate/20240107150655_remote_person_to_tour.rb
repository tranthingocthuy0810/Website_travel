class RemotePersonToTour < ActiveRecord::Migration[6.0]
  def change
    remove_column :tours, :person, :integer
  end
end
