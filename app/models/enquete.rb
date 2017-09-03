class Enquete < ApplicationRecord
  # Association
  belongs_to :reservation
  has_many :enquete_answer

  # Validation
  validates :answer_date, presence: true
end
