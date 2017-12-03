class ReservationPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation_payment

  def show
  end

  def update
    if @reservation_payment.liquidation(params)
      redirect_to mypage_url, notice: '決済を完了しました'
    else
      render :show
    end
  end

  def registed_card
    if @reservation_payment.registed_card_liquidation(current_user)
      redirect_to mypage_url, notice: '決済を完了しました'
    else
      render :show
    end
  end

  private

  def set_reservation_payment
    @reservation_payment = ReservationPayment.find(params[:id])
  end
end
