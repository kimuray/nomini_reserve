class Admin::ReservationsController < AdminController
  before_action :set_reservation, only: [:edit, :update, :destroy, :done, :remand]

  def index
    @reservations = Reservation.includes(:shop, :user).page(params[:page])
  end

  def show
    @reservation = Reservation.includes(:shop, :user, :reservation_category).find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def edit
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to admin_reservation_url(@reservation), notice: 'Reservation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservation_url(@reservation), notice: 'Reservation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to admin_reservations_url, notice: 'Reservation was successfully destroyed.'
  end

  def done
    @reservation.done!
    ReservationMailer.done_reservation_to_user(@reservation).deliver_now
    redirect_to admin_reservation_url(@reservation), notice: '予約を承認しました'
  end

  def remand
    @reservation.remand!
    ReservationMailer.remand_reservation_to_user(@reservation).deliver_now
    redirect_to admin_reservation_url(@reservation), notice: '予約を却下しました'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.fetch(:reservation, {}).permit(
      :shop_id, :user_id, :reservation_category_id, :people_count,
      :use_date, :use_time, :message, :status
    )
  end
end
