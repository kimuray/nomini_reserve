class Payment < ApplicationRecord
  belongs_to :user

  enum status: { cancel: 0, active: 1, trial: 2 }
end
