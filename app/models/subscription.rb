class Subscription < ApplicationRecord
  belongs_to :user

  before_destroy :delete_subscription

  enum status: { cancel: 0, active: 1, trial: 2 }

  # TODO: PayjpApiの呼び出しを後でリファクタリング
  def create_subscription(token, plan)
    payjp_api = PayjpApi.new
    customer = payjp_api.create_customer(token)
    subscription = payjp_api.create_subscription(customer.id, plan)
    self.attributes = { payjp_token: token, customer_id: customer.id, subscription_id: subscription.id }
    self.save
  end
  
  def cancel_subscription
    payjp_api = PayjpApi.new
    payjp_api.cancel_subscription(subscription_id)
    self.cancel!
  end

  def restart_subscription
    payjp_api = PayjpApi.new
    payjp_api.restart_subscription(self.subscription_id)
    self.active!
  end

  def delete_subscription
    payjp_api = PayjpApi.new
    payjp_api.delete_subscription(self.subscription_id)
  end
end
