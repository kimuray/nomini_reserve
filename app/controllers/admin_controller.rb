class AdminController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'admin/application'

  def dashboard
  end
end
