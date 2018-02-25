class Admin::ShopLandscapesController < ApplicationController
  before_action :set_shop_landscape

  def destroy
    @shop_landscape.destroy
    redirect_to edit_landscapes_admin_shop_url(@shop_landscape.shop), notice: '画像を削除しました'
  end

  private

  def set_shop_landscape
    @shop_landscape = ShopLandscape.find(params[:id])
  end
end
