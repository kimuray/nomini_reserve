class ReservationCategory < ApplicationRecord
  # Association
  has_many :reservation

  # Validation
  validates :name, presence: true

end
