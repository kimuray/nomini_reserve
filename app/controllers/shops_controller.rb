class ShopsController < ApplicationController
  # TODO: ログイン周りが完成したらコメントアウト外す
  # before_action :authenticate_user!
  before_action :set_shop, only: :show

  def index
    @shops = Shop.page(params[:page])
  end

  def show
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
