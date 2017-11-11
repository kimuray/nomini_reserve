class ReservationPayment < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates :payjp_token_id, presence: true
  validates :currency, presence: true
  validates :amount, presence: true
end
