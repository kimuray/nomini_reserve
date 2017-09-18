class EnqueteItem < ApplicationRecord
  # Association
  has_many :enquete_answers
  has_many :enquete_selections, dependent: :destroy

  accepts_nested_attributes_for :enquete_selections, allow_destroy: true, reject_if: :all_blank

  enum answer_type: { bool: 0, num: 1, str: 2, selection: 3 }

  def build_select_item
    build_count = 10 - self.enquete_selections.size
    build_count.times { self.enquete_selections.build }
  end
end
