class Admin::PaymentsController < AdminController
  before_action :set_payment, only: [:show, :edit, :update, :destroy, :cancel, :restart]

  def index
    @payments = Payment.page(params[:page])
  end

  def show
  end
  
  def new
    @payment = Payment.new
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to admin_payment_url(@payment), notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to @payment, notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to admin_payments_url, notice: 'Payment was successfully destroyed.'
  end

  def cancel
    @payment.cancel_subscription
    redirect_to admin_payment_url(@payment), notice: '課金を停止しました'
  end

  def restart
    @payment.restart_subscription
    redirect_to admin_payment_url(@payment), notice: '課金を再開しました'
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.fetch(:payment, {}).permit(:user_id, :status, :payjp_token, :customer_id, :subscription_id)
  end
end
