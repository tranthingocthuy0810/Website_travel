class RemoveStatusFromTours < ActiveRecord::Migration[6.0]
  def change
    remove_column :tours, :status, :string
  end
end
