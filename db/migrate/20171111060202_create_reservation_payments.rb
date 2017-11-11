class CreateReservationPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_payments do |t|
      t.references :user, foreign_key: true
      t.references :reservation, foreign_key: true
      t.string :payjp_token_id, null: false
      t.string :currency, default: 'jpy', null: false
      t.integer :amount, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
