class CreateEnqueteItems < ActiveRecord::Migration[5.1]
  def change
    create_table :enquete_items do |t|
      t.text     :content, null: false
      t.integer  :answer_type, null: false, default: 0
      t.boolean  :invalid_flg, default: false

      t.timestamps
    end
  end
end
