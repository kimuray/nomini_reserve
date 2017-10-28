class CreateExchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :exchanges do |t|
      t.references :user, foreign_key: true
      t.integer :point, default: 0, null: false
      t.integer :status, default: 0
      t.datetime :paied_at

      t.timestamps
    end
  end
end
