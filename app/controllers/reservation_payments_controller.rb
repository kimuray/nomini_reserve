class ReservationPaymentsController < ApplicationController
  include AccessCheckable

  before_action :authenticate_user!
  before_action :set_reservation_payment
  before_action :correct_user

  def show
  end

  def update
    if @reservation_payment.liquidation(params)
      send_mails
      current_user.passive_introduction&.point_add
      redirect_to mypage_url, notice: '決済を完了しました'
    else
      render :show
    end
  end

  def registed_card
    if @reservation_payment.registed_card_liquidation(current_user)
      send_mails
      current_user.passive_introduction&.point_add
      redirect_to mypage_url, notice: '決済を完了しました'
    else
      render :show
    end
  end

  private

  def set_reservation_payment
    @reservation_payment = ReservationPayment.find(params[:id])
  end

  def correct_user
    access_check_user(@reservation_payment.user)
  end

  def send_mails
    reservation_benefit = @reservation_payment.reservation.reservation_benefit
    ReservationBenefitMailer.notice_add_point(reservation_benefit).deliver_now
    PaymentMailer.payment_complete(@reservation_payment).deliver_now
  end
end
