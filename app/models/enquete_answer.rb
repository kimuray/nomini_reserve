class EnqueteAnswer < ApplicationRecord
  # Association
  belong_to :enquete_item
  belong_to :enquete

  # Validation
  
end
