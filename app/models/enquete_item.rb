class EnqueteItem < ApplicationRecord
  # Association
  has_many :enquete_answer

  enum answer_type: { bool: 0, num: 1, str: 2 }
end
