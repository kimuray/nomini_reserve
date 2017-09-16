class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  def facebook
    session[:sns_flg] = true
    user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
    if user.persisted?
      # ログインに成功
      flash.notice = "ログインしました"
      sign_in_and_redirect user
    else
      # ログインに失敗し、サインイン画面に遷移
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
