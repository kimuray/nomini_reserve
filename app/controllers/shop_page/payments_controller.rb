class ShopPage::PaymentsController < ApplicationController
  def new
    @reservation_payment = Reservation.find(params[:reservation_id]).setting_payment
  end

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @reservation_payment = @reservation.setting_payment(reservation_payment_params)
    if @reservation_payment.save
      PaymentMailer.notification(@reservation_payment).deliver_now
      redirect_to shop_page_root_url, notice: '支払い情報を確定しました。'
    else
      render :new
    end
  end

  private

  def reservation_payment_params
    params.fetch(:reservation_payment, {}).permit(:amount)
  end
end
