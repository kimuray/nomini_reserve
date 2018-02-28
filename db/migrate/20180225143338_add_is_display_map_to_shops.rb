class AddIsDisplayMapToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :is_display_map, :boolean, default: false, null: false
  end
end
