class ChangePriceToStringToShop < ActiveRecord::Migration[5.1]
  def change
    change_column :shops, :price, :string
  end
end
