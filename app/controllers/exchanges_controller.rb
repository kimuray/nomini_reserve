class ExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exchange, only: [:show, :reapply]
  before_action :check_bank_account

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

  def exchange_params
    params.fetch(:exchange, {}).permit(:point)
  end

  def check_bank_account
    if current_user.bank_account.blank?
      redirect_to new_bank_account_url, notice: '換金申請を行うためには口座情報を登録が必要です'
    end
  end
end
