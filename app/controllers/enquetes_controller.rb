class EnquetesController < ApplicationController
  before_action :authenticate_user!

  def new
    @enquete = Reservation.find(params[:reservation_id]).enquetes.build
  end

  def create
    @enquete = Reservation.find(params[:reservation_id]).enquetes.build(enquete_params)
    if @enquete.save
      redirect_to mypage_url, notice: 'アンケートを作成しました'
    else
      render :new
    end
  end

  private

  def enquete_params
    params.fetch(:enquete, {}).permit(
      enquete_answers_attributes: [:enquete_item_id, :string_value, :integer_value, :boolean_value]
    )
  end
end
