class Reservation < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :shop
  belongs_to :reservation_category
  has_many :enquete

  # Validation
  validates :people_count, presence: true
  validates :use_date, presence: true
  validates :use_time, presence: true
  validates :status  , presence: true

  enum status: { done: 0, visited: 1, answered: 2, canceled: 3 }
end
