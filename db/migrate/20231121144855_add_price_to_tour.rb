class AddPriceToTour < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :price, :decimal
  end
end
