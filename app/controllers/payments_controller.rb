class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
   payment = current_user.build_payment
   token = Payment.create_token(params)
   payment.create_subscription(token.id, ENV['PAYJP_PLAN_ID'])
   redirect_to mypage_url, notice: '支払い情報を保存しました'
  end
end
