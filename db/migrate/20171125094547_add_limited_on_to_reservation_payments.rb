class AddLimitedOnToReservationPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :reservation_payments, :limited_on, :date
  end
end
