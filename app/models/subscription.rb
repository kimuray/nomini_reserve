class Subscription < ApplicationRecord
  belongs_to :user

  USAGE_THRESHOLD = 20_000
  MONTHLY_AMOUNT = 980

  enum status: { cancel: 0, trial: 1, active: 2, examption: 3 }

  validates :customer_id, presence: true
  validates :trail_finished_on, presence: true
  validates :next_charge_on, presence: true

  before_validation :setup_payment_term

  # TODO: PayjpApiの呼び出しを後でリファクタリング
  def create_record(token)
    payjp_api = PayjpApi.new
    self.customer_id = payjp_api.create_customer(token).id
    self.save
  end

  def reset_configure
    user.update!(monthly_usage_amount: 0)
    update!(next_charge_on: 1.months.since)
  end

  def included_trail_term?
    next_charge_on < trail_finished_on
  end

  def achieve_usage_threshold?
    user.monthly_usage_amount >= USAGE_THRESHOLD
  end

  def payment_monthly_amount
    payjp_api = PayjpApi.new
    payjp_api.create_charge_by_registed_card(customer_id, MONTHLY_AMOUNT)
  end

  private

  def setup_payment_term
    if self.trail_finished_on.blank?
      self.trail_finished_on = 2.months.since
    end
    if self.next_charge_on.blank?
      self.next_charge_on = 1.months.since
    end
    self
  end
end
