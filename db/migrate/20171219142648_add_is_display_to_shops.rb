class AddIsDisplayToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :is_display, :boolean, default: false, null: false
  end
end
