class PayjpApi
  def self.create_token(params)
    Payjp::Token.create(
      card: {
        number: params[:number],
        cvc: params[:cvc],
        exp_month: params[:exp_month],
        exp_year: params[:exp_year]
      }
    )
  end

  def create_customer(token)
    Payjp::Customer.create(card: token)
  end

  def create_subscription(customer, plan)
    Payjp::Subscription.create(plan: plan, customer: customer)
  end

  def create_charge(token, amount, currency='jpy')
    Payjp::Charge.create(
      amount: amount,
      card: token,
      currency: currency,
    )
  end

  def cancel_subscription(subscription_id)
    subscription = Payjp::Subscription.retrieve(subscription_id)
    subscription.pause
  end

  def restart_subscription(subscription_id)
    subscription = Payjp::Subscription.retrieve(subscription_id)
    subscription.resume
  end

  def delete_subscription(subscription_id)
    subscription = Payjp::Subscription.retrieve(subscription_id)
    subscription.delete
  end
end
