class ShopPageController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'shop_page/application'
  before_action :authenticate_shop!

  def request_agreement
  end

  def agree
    current_shop.update(is_agree: true)
    redirect_to shop_page_root_url, notice: '利用規約に同意しました'
  end
end
