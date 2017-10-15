class BankAccount < ApplicationRecord
  belongs_to :user

  validates :bank_name, presence: true
  validates :bank_branch_name, presence: true
  validates :bank_account_number, presence: true
end
