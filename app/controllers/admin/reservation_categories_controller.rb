class Admin::ReservationCategoriesController < AdminController
  before_action :set_reservation_category, only: [:show, :edit, :update, :destroy]

  def index
    @reservation_categories = ReservationCategory.page(params[:page])
  end

  def show
  end

  def new
    @reservation_category = ReservationCategory.new
  end

  def edit
  end

  def create
    @reservation_category = ReservationCategory.new(reservation_category_params)
    if @reservation_category.save
      Shop.all.each do |shop|
        shop.shop_usages.create(reservation_category_id: @reservation_category.id)
      end
      redirect_to admin_reservation_category_url(@reservation_category), notice: 'Reservation category was successfully created.'
    else
      render :new
    end
  end

  def update
      if @reservation_category.update(reservation_category_params)
        redirect_to admin_reservation_category_url(@reservation_category), notice: 'Reservation category was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @reservation_category.destroy
    redirect_to admin_reservation_categories_url, notice: 'Reservation category was successfully destroyed.'
  end

  private

  def set_reservation_category
    @reservation_category = ReservationCategory.find(params[:id])
  end

  def reservation_category_params
    params.fetch(:reservation_category, {}).permit(:name)
  end
end
