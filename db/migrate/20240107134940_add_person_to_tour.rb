class AddPersonToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :person, :integer
  end
end
