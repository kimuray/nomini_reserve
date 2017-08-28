class AdminController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'admin/application'

  before_action :authenticate_admin!

  def dashboard
  end
end
