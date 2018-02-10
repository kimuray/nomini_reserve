class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save(context: :member_create)
      bulk_subscription_create
      redirect_to new_user_session_path
    else
      render :new
    end
  end

  private
  def user_params
    params.fetch(:user, {}).permit(
      :email, :password, :password_confirmation, :confirmed_at, :l_name_kana, :f_name_kana, :phone_number
    )
  end

  def bulk_subscription_create
    ActiveRecord::Base.transaction do
      @subscription = @user.build_subscription
      begin
        token = params['payjpToken']
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
      @subscription.create_record(token)
    end
  end
end
