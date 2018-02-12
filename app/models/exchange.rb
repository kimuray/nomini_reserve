class Exchange < ApplicationRecord
  EXCHANGE_LINE = SystemSetting.exchange_line

  belongs_to :user

  enum status: { pending: 0, done: 1, remand: 2 }

  validates :point, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: EXCHANGE_LINE }
  validate :less_than_possession_points

  after_create :update_point_balance

  def remand_apply!(reason)
    point_diff = user.point_count + point
    ActiveRecord::Base.transaction do
      update!(remand_reason: reason, status: :remand)
      user.update!(point_count: point_diff)
    end
  end

  private

  def less_than_possession_points
    if point.present? && user.point_count < point
      errors.add(:point, 'は所持ポイントより大きな値は設定できません')
    end
  end

  def update_point_balance
    point_diff = user.point_count - point
    user.update!(point_count: point_diff)
  end
end
