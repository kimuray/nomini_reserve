class Introduction < ApplicationRecord

  # 紹介したユーザーに加算されるポイント
  INTRODUCTION_POINT = 2_000

  # Association
  belongs_to :user
  belongs_to :introduced_user, class_name: "User", optional: true

  # Validation
  validates :user_id, presence: true
  validates :introduced_email, presence: true
  validates :introduction_token, presence: true

  enum status: { sent: 0, registered: 1, provided: 2 }

  # scope
  scope :find_by_token, -> token { find_by(introduction_token: token) }

  # 友人紹介から登録された際のステータス変更&ユーザーID登録
  def registrate(user_id)
    self.registered! unless self.provided?
    self.introduced_user_id = user_id
    self.save!
  end

  # 友人紹介から利用したユーザーの場合、紹介者にポイント付与
  def point_add
    if registered?
      ActiveRecord::Base.transaction do
        user.point_count += INTRODUCTION_POINT
        user.save!
        provided!
      end
    end
  end
end
