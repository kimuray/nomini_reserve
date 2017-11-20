class ChangeNullTrueToReservationPayments < ActiveRecord::Migration[5.1]
  def change
    change_column :reservation_payments, :payjp_token_id, :string, null: true
  end
end
