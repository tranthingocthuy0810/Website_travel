class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :title, limit: 100
      t.string :description, limit: 1000
      t.string :status, default: "draft"

      t.timestamps
    end
  end
end
