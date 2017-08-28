class CreateReservationCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_categories do |t|
      t.string   :name,null: false
      t.timestamps
    end
  end
end
