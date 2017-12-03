module AccessCheckable
  extend ActiveSupport::Concern

  private

  def confirm_subscription_existed
    if current_user.subscription.blank?
      redirect_to new_subscription_url, notice: '予約するためにはクレジットカード登録が必要です。'
    end
  end
end
