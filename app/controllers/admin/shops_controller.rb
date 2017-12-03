class Admin::ShopsController < AdminController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  def index
    @shops = Shop.page(params[:id])
  end

  def show
    @reservation_categories = ReservationCategory.all
    @shop_usages = @shop.shop_usages
  end

  def new
    @shop = Shop.new
    @shop.shop_usages.build
    @reservation_categories = ReservationCategory.all
    @shop.prefecture_id ||= Prefecture::DEFAULT
  end

  def edit
    @reservation_categories = ReservationCategory.all
  end

  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      redirect_to admin_shop_url(@shop), notice: 'Shop was successfully created.'
    else
      render :new
    end
  end

  def update
    @reservation_categories = ReservationCategory.all
    if @shop.update(shop_params)
      redirect_to admin_shop_url(@shop), notice: 'Shop was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    redirect_to admin_shops_url, notice: 'Shop was successfully destroyed.'
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.fetch(:shop, {}).permit(
      :email, :password, :password_confirmation, :name, :description, :prefecture_id, :city_code, :area_text, :address_detail, :image, :image_cache,
      :service_time, :price, :phone_number, shop_usages_attributes: [:id, :reservation_category_id, :price]
    )
  end
end
