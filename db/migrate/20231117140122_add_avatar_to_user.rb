class AddAvatarToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :string, limit: 500
  end
end
