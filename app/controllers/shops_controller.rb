class ShopsController < ApplicationController
  include AccessCheckable

  before_action :authenticate_shop!, only: [:edit, :update]
  before_action :confirm_agreement,  only: [:edit, :update]
  before_action :authenticate_user!, unless: :shop_signed_in?
  before_action :confirm_subscription_existed, only: [:show], if: :user_signed_in?
  before_action :set_shop, only: [:show]

  def index
    @shops = Shop.page(params[:page])
  end

  def show
    @reservation = Shop.find(params[:id]).reservations.build
  end

  def edit
    @shop = current_shop
    @shop.build_shop_usages
    @shop.prefecture_id ||= Prefecture::DEFAULT
  end

  def update
    @shop = current_shop
    if @shop.update_without_password(shop_params)
      redirect_to shop_page_root_url, notice: '店舗情報を更新しました'
    else
      render :edit
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.fetch(:shop, {}).permit(
       :email, :name, :image, :image_cache, :phone_number, :description, :prefecture_id, :city_code, :area_text, :address_detail, :service_time, :price,
       shop_usages_attributes: [:id, :reservation_category_id, :price]
    )
  end
end
