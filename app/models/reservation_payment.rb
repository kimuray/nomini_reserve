class ReservationPayment < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates :payjp_token_id, presence: true, unless: :requested?
  validates :currency, presence: true
  validates :amount, presence: true

  enum status: { requested: 0, paid: 1 }

  def create_charge
    payjp_api = PayjpApi.new
    payjp_api.create_charge(payjp_token_id, amount)
  end
end
