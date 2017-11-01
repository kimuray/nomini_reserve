class Admin::ReservationBenefitsController < AdminController
  before_action :set_reservation_benefit, only: [:show, :edit, :update, :destroy, :done, :remand]

  def index
    @reservation_benefits = ReservationBenefit.page(params[:page])
  end

  def show
  end

  def new
    @reservation_benefit = ReservationBenefit.new
  end

  def edit
  end

  def create
    @reservation_benefit = ReservationBenefit.new(reservation_benefit_params)

    if @reservation_benefit.save
      redirect_to admin_reservation_benefit_url(@reservation_benefit), notice: 'Apply point was successfully created.'
    else
      render :new
    end
  end

  def update
    if @reservation_benefit.update(reservation_benefit_params)
      redirect_to admin_reservation_benefit_url(@reservation_benefit), notice: 'Apply point was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reservation_benefit.destroy
    redirect_to admin_reservation_benefits_url, notice: 'Apply point was successfully destroyed.'
  end

  def done
    @reservation_benefit.grant_to_user!
    redirect_to admin_reservation_benefit_url(@reservation_benefit), notice: 'ポイントを承認しました'
  end

  def remand
    @reservation_benefit.remand!
    redirect_to admin_reservation_benefit_url(@reservation_benefit), notice: 'ポイントを却下しました'
  end

  private

  def set_reservation_benefit
    @reservation_benefit = ReservationBenefit.find(params[:id])
  end

  def reservation_benefit_params
    params.fetch(:reservation_benefit, {}).permit(:reservation_id, :user_id, :point, :status, :use_price)
  end
end
