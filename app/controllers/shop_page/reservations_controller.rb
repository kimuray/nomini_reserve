class ShopPage::ReservationsController < ShopPageController

  def index
    @reservations = current_shop.reservations.page(params[:page])
  end

end
