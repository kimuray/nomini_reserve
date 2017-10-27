class ApplyPoint < ApplicationRecord
  belongs_to :reservation
  belongs_to :user

  enum status: { pending: 0, done: 1, remand: 2, resubmit: 3 }
end
