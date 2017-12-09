class Batches::SubscriptionBatch < Batches::Base
  def self.exec
    logger.info('Payment confirm batch start')
    logger.debug('show only in dryrun mode.')
    unless dryrun?
      Subscription.includes(:user).where(next_charge_on: Date.today).find_each do |subscription|
        payment_subscription(subscription)
      end
    end
    logger.info('Payment confirm batch finish.')
  end

  def self.payment_subscription(subscription)
    begin
      ActiveRecord::Base.transaction do
        if include_trial?(subscription)
          return
        end
        finish_trial(subscription)
        execute_payment(subscription)
        subscription.reset_configure
      end
    rescue => e
      subscription_fail_log(subscription)
    end
  end

  # トライアル期間中の処理
  def self.include_trial?(subscription)
    if subscription.included_trail_term?
      use_price = subscription.user.monthly_usage_amount
      subscription.reset_configure
      trail_log(subscription, use_price)
      return true
    end
    false
  end

  # トライアル終了
  def self.finish_trial(subscription)
    if subscription.trial?
      subscription.active!
      finish_trail_log(subscription)
    end
  end

  # 課金処理
  def self.execute_payment(subscription)
    unless subscription.achieve_usage_threshold?
      subscription.payment_monthly_amount
      payment_log(subscription)
    else
      examption_log(subscription)
    end
  end


  # Logger
  def self.trail_log(subscription, use_price)
    logger.info("Trail_examption,#{subscription.id},#{subscription.user_id},#{Date.today},#{use_price}")
  end

  def self.finish_trail_log(subscription)
    logger.info("Finish_trail,#{subscription.id},#{subscription.user_id},#{Date.today}")
  end

  def self.payment_log(subscription)
    logger.info("Payment_subscription,#{subscription.id},#{subscription.user_id},#{Date.today},#{subscription.user.monthly_usage_amount}")
  end

  def self.examption_log(subscription)
    logger.info("Subscription_exempt,#{subscription.id},#{subscription.user_id},#{Date.today},#{subscription.user.monthly_usage_amount}")
  end

  def self.subscription_fail_log(subscription)
    logger.info("Fail_subscription,#{subscription.id},#{subscription.user_id},#{Date.today},#{subscription.user.monthly_usage_amount}")
  end
end
