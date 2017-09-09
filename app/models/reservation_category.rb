class ReservationCategory < ApplicationRecord
  # Association
  has_many :reservation
  has_many :shops, through: :shop_reservations
  has_many :shop_reservations, dependent: :destroy

  # Validation
  validates :name, presence: true

end
