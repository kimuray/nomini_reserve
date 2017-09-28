class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:shop).page(params[:page])
    @recommend_shops = Shop.limit(3)
  end

  def show
    @reservation = Reservation.includes(:shop, :reservation_category).find(params[:id])
  end

  #def new
  #  @reservation = Reservation.includes(:reservation_category).new
  #  @reservation.shop = Shop.find(params[:shop_id])
  #end

  def create
    @reservation = Reservation.new(reservation_params)
    if params[:back]
      @shop = @reservation.shop
      render template: "shops/show"
    elsif @reservation.save
      redirect_to shop_reservations_url, notice: '予約しました。'
    else
      @shop = @reservation.shop
      render template: "shops/show"
    end
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
  end

  private
  def reservation_params
    params.fetch(:reservation, {}).permit(
      :shop_id, :user_id, :reservation_category_id, :people_count,
      :use_date, :use_time, :message, :status
    )
  end
end
