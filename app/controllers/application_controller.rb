class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    mypage_path
  end

  protected

    # deviseカラム追加
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:l_name,:f_name,:l_name_kana,:f_name_kana,:enterprise_name,:phone_number,:bank_name,:bank_branch_name,:bank_account_number])
      devise_parameter_sanitizer.permit(:account_update, keys: [:l_name,:f_name,:l_name_kana,:f_name_kana,:enterprise_name,:phone_number,:bank_name,:bank_branch_name,:bank_account_number])
    end
end
