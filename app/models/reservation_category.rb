class ReservationCategory < ApplicationRecord
  # Association
  has_many :reservation
  has_many :shops, through: :shop_usages
  has_many :shop_usages, dependent: :destroy

  # Validation
  validates :name, presence: true

end
