class AddSalesCountToTours < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :sales_count, :integer, null: false, default: 0
  end
end
