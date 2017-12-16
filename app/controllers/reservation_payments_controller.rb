class ReservationPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation_payment

  def show
  end

  def update
    if @reservation_payment.liquidation(params)
      send_mails
      redirect_to mypage_url, notice: '決済を完了しました'
    else
      render :show
    end
  end

  def registed_card
    if @reservation_payment.registed_card_liquidation(current_user)
      send_mails
      redirect_to mypage_url, notice: '決済を完了しました'
    else
      render :show
    end
  end

  private

  def set_reservation_payment
    @reservation_payment = ReservationPayment.find(params[:id])
  end

  def send_mails
    reservation_benefit = @reservation_payment.reservation.reservation_benefit
    ReservationBenefitMailer.notice_add_point(reservation_benefit).deliver_now
    PaymentMailer.payment_complete(@reservation_payment).deliver_now
  end
end
