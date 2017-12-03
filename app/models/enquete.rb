class Enquete < ApplicationRecord
  # Association
  belongs_to :reservation
  has_many :enquete_answers, dependent: :destroy

  # Validation
  validates :answer_date, presence: true

  accepts_nested_attributes_for :enquete_answers

  after_create :create_reservation_benefit_record

  private

  def create_reservation_benefit_record
    reservation_benefit = reservation.build_reservation_benefit(
      user: reservation.user,
      use_price: reservation.sum_price
    )
    reservation_benefit.set_point
    reservation_benefit.save
    reservation.answered!
  end
end
