class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string   :name, null: false
      t.text     :description
      t.string   :image
      t.float    :service_time
      t.decimal  :price
      t.string   :phone_number

      t.timestamps
    end
  end
end
