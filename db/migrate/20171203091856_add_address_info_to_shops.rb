class AddAddressInfoToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :area_text, :text
    add_column :shops, :address_detail, :text
  end
end
