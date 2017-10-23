class Introduction < ApplicationRecord
  # Association
  belongs_to :user

  # Validation
  validates :user_id, presence: true
  validates :introduced_email, presence: true
  validates :introduction_token, presence: true

  enum status: { sent: 0, registered: 1, provided: 2 }

  def registrate(user_id)
    self.registered! unless provided?
    self.introduced_id = user_id
    self.save!
  end
end
