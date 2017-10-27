class ApplyPoint < ApplicationRecord
  EXCHANGE_RATE = 0.1

  belongs_to :reservation
  belongs_to :user

  enum status: { pending: 0, done: 1, remand: 2, resubmit: 3 }

  def set_point
    self.point = (use_price * EXCHANGE_RATE).to_i
  end
end
