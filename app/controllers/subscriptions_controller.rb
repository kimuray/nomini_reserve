class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def create
    subscription = current_user.build_subscription
    token = PayjpApi.create_token(params)
    subscription.create_subscription(token.id, ENV['PAYJP_PLAN_ID'])
    redirect_to mypage_url, notice: '支払い情報を保存しました'
  end
end
