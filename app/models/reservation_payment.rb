class ReservationPayment < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates :limited_on, presence: true
  validates :currency, presence: true
  validates :amount, presence: true
  validate :valid_payjp_info, unless: :requested?

  enum status: { requested: 0, paid: 1, force_paid: 2, failed: 3 }

  def tax_included_amount
    (amount * Settings.consumption_tax).to_i
  end

  def liquidation(params)
    payjp_api = PayjpApi.new
    begin
      ActiveRecord::Base.transaction do
        token = PayjpApi.create_token(params)
        update!(payjp_token_id: token.id, status: :paid)
        payjp_api.create_charge(payjp_token_id, tax_included_amount)
      end
    rescue => e
      errors[:base] << '支払いに失敗しました'
      return false
    end
    true
  end

  # OPTIMIZE: liquidationと似た処理が多いので最適化できるかも
  def force_liquidation(token_id)
    payjp_api = PayjpApi.new
    begin
      ActiveRecord::Base.transaction do
        update!(payjp_token_id: token_id, status: :force_paid)
        payjp_api.create_charge(payjp_token_id, tax_included_amount)
      end
    rescue => e
      failed!
      return false
    end
    true
  end

  def registed_card_liquidation(user)
    payjp_api = PayjpApi.new
    begin
      ActiveRecord::Base.transaction do
        update!(customer_id: user.subscription.customer_id, status: :paid)
        payjp_api.create_charge_by_registed_card(customer_id, tax_included_amount)
      end
    rescue => e
      errors[:base] << '支払いに失敗しました'
      return false
    end
    true
  end

  private

  def valid_payjp_info
    if payjp_token_id.blank? && customer_id.blank?
      errors[:base] << '支払い情報に誤りがあります'
    end
  end
end
