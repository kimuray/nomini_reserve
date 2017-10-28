class Admin::ExchangesController < AdminController
  before_action :set_exchange, only: [:show, :edit, :update, :destroy, :done, :remand]

  def index
    @exchanges = Exchange.page(params[:page])
  end

  def show
  end

  def new
    @exchange = Exchange.new
  end

  def edit
  end

  def create
    @exchange = Exchange.new(exchange_params)

    if @exchange.save
      redirect_to admin_exchange_url(@exchange), notice: 'Exchange was successfully created.'
    else
      render :new
    end
  end

  def update
    if @exchange.update(exchange_params)
      redirect_to admin_exchange_url(@exchange), notice: 'Exchange was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @exchange.destroy
    redirect_to admin_exchanges_url, notice: 'Exchange was successfully destroyed.'
  end

  def done
    @exchange.done!
    redirect_to admin_exchange_url(@exchange), notice: '換金を完了しました'
  end

  def remand
    @exchange.remand_apply!(exchange_params[:remand_reason])
    redirect_to admin_exchange_url(@exchange), notice: '換金を差し戻しました'
  end

  private

  def set_exchange
    @exchange = Exchange.find(params[:id])
  end

  def exchange_params
    params.fetch(:exchange, {}).permit(:user_id, :point, :paied_at, :status, :remand_reason)
  end
end
