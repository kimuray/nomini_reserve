class CreateEnqueteSelections < ActiveRecord::Migration[5.1]
  def change
    create_table :enquete_selections do |t|
      t.references :enquete_item, foreign_key: true
      t.string :content
      t.integer :answer_value
      
      t.timestamps
    end
    add_index :enquete_selections, [:enquete_item_id, :answer_value], unique: true

    add_column :enquete_items, :select_value, :integer, index: true
  end
end
