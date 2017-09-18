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
    when 'selection'
      enquete_item.enquete_selections.find_by(answer_value: integer_value).content
    end
  end
end
