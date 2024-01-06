class AddQuantityToTours < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :quantity, :integer
  end
end
