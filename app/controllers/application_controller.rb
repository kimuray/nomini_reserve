class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # deviseカラム追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:l_name,:f_name,:l_name_kana,:f_name_kana,:enterprise_name,:phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:l_name,:f_name,:l_name_kana,:f_name_kana,:enterprise_name,:phone_number])
  end
end
