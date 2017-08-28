class Admin::ShopsController < AdminController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  
  def index
    @shops = Shop.all
  end

  def show
  end

  def new
    @shop = Shop.new
  end

  def edit
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
    if @shop.update(admin_shop_params)
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
      :name, :description, :image, :service_time, :price, :phone_number
    )
  end
end
