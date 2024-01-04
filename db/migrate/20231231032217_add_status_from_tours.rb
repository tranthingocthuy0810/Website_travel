class AddStatusFromTours < ActiveRecord::Migration[6.0]
  def change
    add_column :tours, :status, :string, default: "popular"
  end
end
