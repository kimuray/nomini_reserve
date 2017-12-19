class ShopPage::PaymentsController < ApplicationController
  include AccessCheckable

  before_action :confirm_agreement
  before_action :set_reservation
  before_action :correct_shop

  def new
    @reservation_payment = @reservation.setting_payment
  end

  def create
    @reservation_payment = @reservation.setting_payment(reservation_payment_params)
    if @reservation_payment.save
      PaymentMailer.notification(@reservation_payment).deliver_now
      redirect_to shop_page_root_url, notice: '支払い情報を確定しました。'
    else
      render :new
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:reservation_id])
  end

  def correct_shop
    access_check_shop(@reservation.shop)
  end

  def reservation_payment_params
    params.fetch(:reservation_payment, {}).permit(:amount)
  end
end
