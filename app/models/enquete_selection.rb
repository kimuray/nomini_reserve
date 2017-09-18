class EnqueteSelection < ApplicationRecord
  belongs_to :enquete_item
  
  validates :content, presence: true
  validates :answer_value, presence: true
end
