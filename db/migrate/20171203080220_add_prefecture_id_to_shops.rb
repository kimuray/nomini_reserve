class AddPrefectureIdToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :prefecture_id, :integer
  end
end
