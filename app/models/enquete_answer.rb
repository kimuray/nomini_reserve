class EnqueteAnswer < ApplicationRecord
  # Association
  belongs_to :enquete_item
  belongs_to :enquete

  # Validation
  
  def feedback
    case enquete_item.answer_type
    when 'bool'
      boolean_value
    when 'num'
      integer_value
    when 'str'
      string_value
    end
  end
end
