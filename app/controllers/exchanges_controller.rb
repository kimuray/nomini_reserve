class ExchangesController < ApplicationController
  before_action :authenticate_user!

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

  private

  def exchange_params
    params.fetch(:exchange, {}).permit(:point)
  end
end
