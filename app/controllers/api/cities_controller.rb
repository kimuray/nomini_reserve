class Api::CitiesController < ApiController
  def index
    @cities = City.where(prefecture_id: params[:prefecture_id]).order(:id)
  end
end
