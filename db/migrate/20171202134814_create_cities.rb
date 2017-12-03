class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string   "name",             null: false
      t.integer  "prefecture_id",    null: false
      t.string   "city_code",        null: false
      t.integer  "big_city_flag",    null: false
      t.timestamps
    end
    add_index :cities, :prefecture_id
    add_index :cities, :city_code, unique: true
  end
end
