class SubscriptionsController < ApplicationController
  def new
    @user = current_user
    @subscription = Subscription.new
  end

  def create
    ActiveRecord::Base.transaction do
      @user = current_user
      @subscription = current_user.build_subscription
      if @user.update(user_params)
        begin
          token = PayjpApi.create_token(params)
        rescue Payjp::CardError => e
          body = e.json_body
          err = body[:error]
          flash.now[:alert] = t("payjp.#{err[:code]}")
          render :new and return
        rescue => e
          #TODO カード情報以外起因のエラー処理
          flash.now[:alert] = "決済エラーが発生しました。"
          render :new and return
        end
        @subscription.create_record(token.id)
        redirect_to mypage_url, notice: '支払い情報を保存しました'
      else
        render :new
      end
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(
      :phone_number, :l_name_kana, :f_name_kana
    )
  end
end
