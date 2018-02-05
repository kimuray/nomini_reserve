class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy, :password_edit ,:password_update]
  before_action :set_introduction_params, only: [:new]
  after_action :introduction_registrate, only: [:create]

  def new
    @subscription = Subscription.new if params[:bulk]
    super
  end

  def create
    super do
      if params[:payjpToken]
        if !resource.persisted?
          @subscription = Subscription.new
          render :new and return
        end
        bulk_subscription_create
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # パスワード更新画面
  def password_edit
  end

  def password_update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      redirect_to users_edit_password_path, notice: '現在のパスワード、または更新パスワードが無効です。'
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    mypage_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def bulk_subscription_create
    ActiveRecord::Base.transaction do
      @subscription = resource.build_subscription
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

  private
  def password_params
    params.fetch(:user, {}).permit(
      :password, :password_confirmation, :current_password
    )
  end

  def set_introduction_params
    session[:introduction_token] = params[:introduction_token] if params[:introduction_token].present?
  end

  # 紹介されたユーザーの場合、紹介ステータスの更新&ユーザーID登録
  def introduction_registrate
    if session[:introduction_token].present? && resource.persisted?
      Introduction.find_by_token(session[:introduction_token]).registrate(resource.id)
      session.delete(:introduction_token)
    end
  end

  protected

  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params)
    else
      super
    end
  end

end
