class Enquete < ApplicationRecord
  # Association
  belongs_to :reservation
  has_many :enquete_answers

  # Validation
  validates :answer_date, presence: true

  accepts_nested_attributes_for :enquete_answers
end
