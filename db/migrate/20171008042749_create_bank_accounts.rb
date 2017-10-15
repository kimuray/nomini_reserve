class CreateBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.references :user, foreign_key: true
      t.string   :bank_name
      t.string   :bank_branch_name
      t.string   :bank_account_number
      t.timestamps
    end
  end
end
