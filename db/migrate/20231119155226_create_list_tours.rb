class CreateListTours < ActiveRecord::Migration[6.0]
  def change
    create_table :list_tours do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
