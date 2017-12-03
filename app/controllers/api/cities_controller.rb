class Api::CitiesController < ApiController
  def index
    @cities = City.where(prefecture_id: params[:prefecture_id])
  end
end
