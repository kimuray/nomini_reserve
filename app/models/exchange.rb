class Exchange < ApplicationRecord
  belongs_to :user

  validates :point, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 10_000 }
  validate :less_than_possession_points

  private

  def less_than_possession_points
    if user.point_count < point
      errors.add(:point, 'は所持ポイントより大きな値は設定できません')
    end
  end
end
