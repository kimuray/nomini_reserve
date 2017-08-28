class Reservation < ApplicationRecord
  # Association
  belong_to :user
  belong_to :shop
  belong_to :reservation_category
  has_many :enquete

  # Validation
  validates :people_count, presence: true
  validates :use_date, presence: true
  validates :use_time, presence: true
  validates :status  , presence: true

end
