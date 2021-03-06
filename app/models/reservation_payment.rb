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

  # TODO: 決済処理に似た処理が多いため要リファクタリング
  def liquidation(token)
    payjp_api = PayjpApi.new
    begin
      ActiveRecord::Base.transaction do
        update!(payjp_token_id: token, status: :paid)
        reservation.paid!
        payjp_api.create_charge(payjp_token_id, amount)
        grant_benefit_after_paid
      end
    rescue => e
      errors[:base] << '支払いに失敗しました'
      return false
    end
    true
  end

  # OPTIMIZE: liquidationと似た処理が多いので最適化できるかも
  def force_liquidation(customer_id)
    payjp_api = PayjpApi.new
    begin
      ActiveRecord::Base.transaction do
        update!(payjp_token_id: customer_id, status: :force_paid)
        payjp_api.create_charge_by_registed_card(customer_id, amount)
        grant_benefit_after_paid
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
        payjp_api.create_charge_by_registed_card(customer_id, amount)
        grant_benefit_after_paid
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

  def create_reservation_benefit_record
    reservation_benefit = reservation.build_reservation_benefit(
      user: user,
      use_price: amount
    )
    reservation_benefit.set_point
    reservation_benefit.save!
    reservation_benefit.grant_to_user! # TODO: 既存の仕組みをそのまま利用しているためリファクタ必要
  end

  def grant_benefit_after_paid
    if reservation.is_alacarte
      create_reservation_benefit_record
      user.add_monthly_usage_amount!(amount)
    end
    reservation.paid!
  end
end
