class EnquetesController < ApplicationController
  before_action :authenticate_user!

  def new
    @enquete = Reservation.find(params[:reservation_id]).enquetes.build
    EnqueteItem.ids.each { |item_id| @enquete.enquete_answers.build(enquete_item_id: item_id) }
  end

  def create
    @enquete = Reservation.find(params[:reservation_id]).enquetes.build(enquete_params)
    @enquete.answer_date = Date.today
    if @enquete.save
      current_user.passive_introduction.point_add
      redirect_to mypage_url, notice: 'アンケートを送信しました'
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
