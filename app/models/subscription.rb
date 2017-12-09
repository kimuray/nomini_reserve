class Subscription < ApplicationRecord
  belongs_to :user

  before_destroy :delete_record

  enum status: { cancel: 0, trial: 1, active: 2, examption: 3 }

  validates :customer_id, presence: true

  # TODO: PayjpApiの呼び出しを後でリファクタリング
  def create_record(token)
    payjp_api = PayjpApi.new
    self.customer_id = payjp_api.create_customer(token).id
    self.save
  end
  
  def cancel
    payjp_api = PayjpApi.new
    payjp_api.cancel_subscription(subscription_id)
    self.cancel!
  end

  def restart
    payjp_api = PayjpApi.new
    payjp_api.restart_subscription(self.subscription_id)
    self.active!
  end

  def delete_record
    payjp_api = PayjpApi.new
    payjp_api.delete_subscription(self.subscription_id)
  end
end
