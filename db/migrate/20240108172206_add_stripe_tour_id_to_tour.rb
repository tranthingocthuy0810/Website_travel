class AddStripeTourIdToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :stripe_tour_id, :string
  end
end
