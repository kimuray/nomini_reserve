class Subscription < ApplicationRecord
  belongs_to :user

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
