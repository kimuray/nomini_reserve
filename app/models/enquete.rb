class Enquete < ApplicationRecord
  # Association
  belongs_to :reservation
  has_many :enquete_answers

  # Validation
  validates :answer_date, presence: true
end
