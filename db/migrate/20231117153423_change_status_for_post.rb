class ChangeStatusForPost < ActiveRecord::Migration[5.2]
  def change
    change_column(:posts, :status, :string)
  end
end
