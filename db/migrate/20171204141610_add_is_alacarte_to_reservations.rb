class AddIsAlacarteToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :is_alacarte, :boolean, default: false, null: false
  end
end
