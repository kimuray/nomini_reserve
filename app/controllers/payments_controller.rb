class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
   payment = current_user.build_payment
   payment.create_subscription(params['payjp-token'])
   redirect_to mypage_url, notice: '支払い情報を保存しました'
  end
end
