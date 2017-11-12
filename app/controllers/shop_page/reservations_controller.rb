class ShopPage::ReservationsController < ShopPageController

  def index
    @reservations = current_shop.reservations.page(params[:page])
  end

  def new
    @reservation = current_shop.reservations.build
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = User.find(params[:reservation][:customer_id])
    @reservation.shop = current_shop
    if params[:back].blank? && @reservation.save
      send_reservation_mail
      redirect_to shop_page_root_path, notice: '予約を作成しました。'
    else
      render :new
    end
  end

  def confirm
    @customer_user = User.find_by(phone_number: params[:reservation][:phone_number])
    @reservation = Reservation.new(reservation_params)
    if @customer_user.blank?
      @reservation.errors[:base] << 'お客様情報が見つかりませんでした。'
      render :new and return
    end
    @reservation.user_id = @customer_user&.id
    @reservation.shop_id = current_shop.id
    unless @reservation.valid?
      render :new
    end
  end

  private

  def reservation_params
    params.fetch(:reservation, {}).permit(
      :shop_id, :user_id, :reservation_category_id, :people_count,
      :use_date, :use_time, :message, :status
    )
  end

  def send_reservation_mail
    ReservationMailer.notice_reservation_to_nomini(@reservation).deliver_now
    ReservationMailer.notice_reservation_to_user(@reservation).deliver_now
  end


end
