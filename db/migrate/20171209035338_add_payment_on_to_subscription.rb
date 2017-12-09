class AddPaymentOnToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :next_charge_on, :date, null: false
    add_column :subscriptions, :trail_finished_on, :date, null: false
    add_column :users, :monthly_usage_amount, :integer, null: false, default: 0
  end
end
