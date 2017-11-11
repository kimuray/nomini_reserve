class CreateReservationPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_payments do |t|
      t.references :user, foreign_key: true
      t.references :reservation, foreign_key: true
      t.string :payjp_token_id
      t.string :currency
      t.integer :amount
      t.integer :status

      t.timestamps
    end
  end
end
