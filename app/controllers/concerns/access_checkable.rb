module AccessCheckable
  extend ActiveSupport::Concern

  private

  def confirm_subscription_existed
    if current_user.subscription.blank?
      redirect_to description_subscriptions_url, notice: '予約するためにはクレジットカード登録が必要です。'
    end
  end

  def confirm_agreement
    unless current_shop.is_agree
      redirect_to shop_page_request_agreement_url, notice: '店舗機能を利用するためには利用規約の同意が必要です'
    end
  end

  def access_check_user(user)
    unless user == current_user
      redirect_to root_url, notice: 'ページのアクセスが許可されていません'
    end
  end

  def access_check_shop(shop)
    unless shop == current_shop
      redirect_to shop_page_root_url, notice: 'ページのアクセスが許可されていません'
    end
  end
end
