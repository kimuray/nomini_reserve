class CreateShopUsages < ActiveRecord::Migration[5.1]
  def change
    create_table :shop_usages do |t|
      t.references :shop, foreign_key: true
      t.references :reservation_category, foreign_key: true
      t.decimal  :price

      t.timestamps
    end
    add_index :shop_usages, [:shop_id, :reservation_category_id], unique: true
  end
end
