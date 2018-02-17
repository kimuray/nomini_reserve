class CreateShopLandscapes < ActiveRecord::Migration[5.1]
  def change
    create_table :shop_landscapes do |t|
      t.references :shop, foreign_key: true, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
