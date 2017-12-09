class Batches::SubscriptionBatch < Batches::Base
  def self.exec
    logger.info('Payment confirm batch start')
    logger.debug('show only in dryrun mode.')
    unless dryrun?
      Subscription.where(next_charge_on: Date.today).find_each do |subscription|
        payment_subscription(subscription)
      end
    end
    logger.info('Payment confirm batch finish.')
  end

  def self.payment_subscription(subscription)
    begin
    ActiveRecord::Base.transaction do
      # トライアル期間中の処理
      if subscription.trail_finished_on < subscription.next_charge_on
        use_price = subscription.user.monthly_usage_amount
        subscription.user.update!(monthly_usage_amount: 0)
        subscription.update!(next_charge_on: 1.months.since)
        trail_log(subscription, use_price)
        return
      end

      # トライアル終了
      if subscription.trail?
        subscription.active!
        finish_trail_log(subscription)
      end

      # 課金処理
      if subscription.user.monthly_usage_amount < 20_000
        payjp_api = PayjpApi.new
        payjp_api.create_charge_by_registed_card(subscription.customer_id, 980)
        payment_log(subscription)
      else
        examption_log(subscription)
      end

      # 翌月の課金日設定、利用金額リセット
      subscription.user.update!(monthly_usage_amount: 0)
      subscription.update!(next_charge_on: 1.months.since)
    end
    rescue => e
      subscription_fail_log(subscription)
    end
  end

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
