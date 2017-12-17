class ExchangesController < ApplicationController
  include AccessCheckable

  before_action :authenticate_user!
  before_action :set_exchange, only: [:show, :reapply]
  before_action :correct_user, only: [:show, :reapply]

  def show
  end

  def new
    @exchange = Exchange.new
  end

  def create
    @exchange = current_user.exchanges.build(exchange_params)
    if @exchange.save
      redirect_to mypage_url, notice: '換金申請を行いました。担当者から連絡があるまでお待ちください。'
    else
      render :new
    end
  end

  def reapply
    if @exchange.update(exchange_params)
      @exchange.resubmit!
      redirect_to exchange_url(@exchange), notice: '換金再申請を行いました'
    else
      render :show
    end
  end

  private

  def set_exchange
    @exchange = Exchange.find(params[:id])
  end

  def correct_user
    access_check_user(@exchange.user)
  end

  def exchange_params
    params.fetch(:exchange, {}).permit(:point)
  end
end
