class Admin::ReservationPaymentsController < AdminController
  before_action :set_reservation_payment, only: [:show, :edit, :update, :destroy]

  def index
    @reservation_payments = ReservationPayment.page(params[:page])
  end

  def show
  end

  def new
    @reservation_payment = ReservationPayment.new
  end

  def edit
  end

  def create
    @reservation_payment = ReservationPayment.new(reservation_payment_params)

    if @reservation_payment.save
      redirect_to admin_reservation_payment_url(@reservation_payment), notice: 'Reservation payment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @reservation_payment.update(reservation_payment_params)
      redirect_to admin_reservation_payment_url(@reservation_payment), notice: 'Reservation payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reservation_payment.destroy
    redirect_to admin_reservation_payments_url, notice: 'Reservation payment was successfully destroyed.'
  end

  private

  def set_reservation_payment
    @reservation_payment = ReservationPayment.find(params[:id])
  end

  def reservation_payment_params
    params.fetch(:reservation_payment, {}).permit(
      :user_id, :reservation_id, :payjp_token_id, :amount, :currency
    )
  end
end
