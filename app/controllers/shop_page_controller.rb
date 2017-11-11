class ShopPageController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'shop_page/application'
  before_action :authenticate_shop!
end
