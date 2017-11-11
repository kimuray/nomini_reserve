class RenamePaymentsToSubscription < ActiveRecord::Migration[5.1]
  def change
    rename_table :payments, :subscriptions
  end
end
