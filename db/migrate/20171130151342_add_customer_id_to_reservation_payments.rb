class AddCustomerIdToReservationPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :reservation_payments, :customer_id, :string, index: true
  end
end
