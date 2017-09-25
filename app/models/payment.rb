class Payment < ApplicationRecord
  belongs_to :user

  enum status: { cancel: 0, active: 1, trial: 2 }

  def create_subscription(token, plan)
    customer = Payjp::Customer.create(card: token)
    subscription = Payjp::Subscription.create(plan: plan, customer: customer.id)
    self.attributes = { payjp_token: token, customer_id: customer.id, subscription_id: subscription.id }
    self.save
  end
  
  def self.create_token(params)
    token = Payjp::Token.create(
      card: { 
        number: params[:number], 
        cvc: params[:cvc], 
        exp_month: params[:exp_month], 
        exp_year: params[:exp_year]
      }
    )
  end
end
