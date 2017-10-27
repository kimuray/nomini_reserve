class Enquete < ApplicationRecord
  # Association
  belongs_to :reservation
  has_many :enquete_answers, dependent: :destroy

  # Validation
  validates :answer_date, presence: true

  accepts_nested_attributes_for :enquete_answers

  after_create :create_apply_point_record

  private

  def create_apply_point_record
    apply_point = reservation.build_apply_point(
      user: reservation.user,
      use_price: reservation.sum_price
    )
    apply_point.set_point
    apply_point.save
  end
end
