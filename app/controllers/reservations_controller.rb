class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:shop).page(params[:page])
    @exchanges = current_user.exchanges.limit(10)
    @recommend_shops = Shop.limit(3)
  end

  def show
    @reservation = Reservation.includes(:shop, :reservation_category).find(params[:id])
  end

  def create
    @reservation = Shop.find(params[:shop_id]).reservations.build(reservation_params)
    @reservation.user_id = current_user.id
    if params[:back].blank? && @reservation.save
      send_reservation_mail
      redirect_to shop_reservations_url, notice: '予約しました。'
    else
      @shop = @reservation.shop
      render template: "shops/show"
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      ReservationMailer.update_reservation_to_user(@reservation).deliver_now
      ReservationMailer.update_reservation_to_nomini(@reservation).deliver_now
      redirect_to reservation_url(@reservation), notice: '予約内容を変更しました。'
    else
      render :edit
    end
  end

  def cancel
    @reservation = Reservation.find(params[:id])
    @reservation.canceled!
    ReservationMailer.cancel_reservation_to_user(@reservation).deliver_now
    ReservationMailer.cancel_reservation_to_nomini(@reservation).deliver_now
    redirect_to root_path, notice: '予約をキャンセルしました'
  end

  def confirm
    @reservation = Shop.find(params[:shop_id]).reservations.build(reservation_params)
    @reservation.user_id = current_user.id
    @shop = @reservation.shop
    unless @reservation.valid?
      render template: "shops/show"
    end
  end

  private

  def reservation_params
    params.fetch(:reservation, {}).permit(
      :shop_id, :user_id, :reservation_category_id, :people_count,
      :use_date, :use_time, :message, :status
    )
  end

  def send_reservation_mail
    ReservationMailer.notice_reservation_to_nomini(@reservation).deliver_now
    ReservationMailer.notice_reservation_to_user(@reservation).deliver_now
  end
end
