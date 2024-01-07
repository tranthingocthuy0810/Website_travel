class AddListTourRefToTours < ActiveRecord::Migration[6.0]
  def change
    add_reference :tours, :list_tour, null: false, foreign_key: true
  end
end
