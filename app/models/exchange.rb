class Exchange < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, done: 1, remand: 2, resubmit: 3 }

  validates :point, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 10_000 }
  validate :less_than_possession_points

  after_create :update_point_balance

  private

  def less_than_possession_points
    if point.present? && user.point_count < point
      errors.add(:point, 'は所持ポイントより大きな値は設定できません')
    end
  end

  def update_point_balance
    point_diff = user.point_count - point
    user.update(point_count: point_diff)
  end
end
