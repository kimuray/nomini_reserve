class CreateReservationBenefits < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_benefits do |t|
      t.integer :point
      t.integer :use_price
      t.integer :reservation_id
      t.integer :user_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
