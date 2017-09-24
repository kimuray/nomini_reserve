class Payment < ApplicationRecord
  belongs_to :user

  enum status: { cancel: 0, active: 1, trial: 2 }

  def create_subscription(token)
    plan = ENV['PAYJP_PLAN_ID']
    customer = Payjp::Customer.create(card: token)
    subscription = Payjp::Subscription.create(plan: plan, customer: customer.id)
    self.attributes = { token_id: token, customer_id: customer.id, subscription_id: subscription.id }
    self.save
  end
end
