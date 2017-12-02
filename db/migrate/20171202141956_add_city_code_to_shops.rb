class AddCityCodeToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :city_code, :string
  end
end
