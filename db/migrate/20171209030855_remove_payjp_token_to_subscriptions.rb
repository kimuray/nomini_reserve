class RemovePayjpTokenToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    remove_column :subscriptions, :payjp_token
    remove_column :subscriptions, :subscription_id
  end
end
