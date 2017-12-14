class RemoveConfirmableToShops < ActiveRecord::Migration[5.1]
  def change
    remove_column :shops, :confirmation_token
    remove_column :shops,:confirmed_at
    remove_column :shops,:confirmation_sent_at
    remove_column :shops,:unconfirmed_email
  end
end
