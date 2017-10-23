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
      introduction_point_add
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

  # 友人紹介から利用したユーザーの場合、紹介者にポイント付与
  def introduction_point_add
    introduction = Introduction.registered&.find_by(introduced_id: current_user.id)
    if introduction.present?
      introduction.user.point_count += 3000
      introduction.user.save!
      introduction.provided!
    end
  end
end
