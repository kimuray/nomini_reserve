class CreateIntroductions < ActiveRecord::Migration[5.1]
  def change
    create_table :introductions do |t|
      t.references :user, foreign_key: true
      t.integer :introduced_id
      t.string :introduced_email
      t.string :introduction_token
      t.integer :status, default: 0
      t.timestamps
    end
    add_index :introductions, [:user_id, :introduced_id], unique: true
  end
end
