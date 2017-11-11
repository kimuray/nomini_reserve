class ReservationPayment < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates :payjp_token_id, presence: true
  validates :currency, presence: true
  validates :amount, presence: true

  def create_charge
    payjp_api = PayjpApi.new
    payjp_api.create_charge(payjp_token_id, amount)
  end
end
