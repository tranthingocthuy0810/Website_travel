class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, limit: 50
      t.string :discription, limit: 500
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
