class Admin::ApplyPointsController < AdminController
  before_action :set_apply_point, only: [:show, :edit, :update, :destroy]

  def index
    @apply_points = ApplyPoint.page(params[:page])
  end

  def show
  end

  def new
    @apply_point = ApplyPoint.new
  end

  def edit
  end

  def create
    @apply_point = ApplyPoint.new(apply_point_params)

    if @apply_point.save
      redirect_to admin_apply_point_url(@apply_point), notice: 'Apply point was successfully created.'
    else
      render :new
    end
  end

  def update
    if @apply_point.update(apply_point_params)
      redirect_to admin_apply_point_url(@apply_point), notice: 'Apply point was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @apply_point.destroy
    redirect_to admin_apply_points_url, notice: 'Apply point was successfully destroyed.'
  end

  private

  def set_apply_point
    @apply_point = ApplyPoint.find(params[:id])
  end

  def apply_point_params
    params.fetch(:apply_point, {}).permit(:reservation_id, :user_id, :point, :status, :use_price)
  end
end
