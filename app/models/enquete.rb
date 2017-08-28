class Enquete < ApplicationRecord
  # Association
  belong_to :reservation
  has_many :enquete_answer

  # Validation
  validates :content, presence: true
  validates :answer_type, presence: true
end
