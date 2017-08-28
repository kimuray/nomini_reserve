class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :shop, foreign_key: true
      t.references :user, foreign_key: true
      t.references :reservation_category, foreign_key: true
      t.integer    :people_count, null: false
      t.date       :use_date, null: false
      t.time       :use_time, null: false
      t.text       :message
      t.integer    :status, null: false,default: 0

      t.timestamps
    end
  end
end
