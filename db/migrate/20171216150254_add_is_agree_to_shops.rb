class AddIsAgreeToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :is_agree, :boolean, default: false, null: false
  end
end
