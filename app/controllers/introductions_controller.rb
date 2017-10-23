class IntroductionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @introduction = current_user.introductions.new
  end

  def create
    @introduction = current_user.introductions.new(introduction_params)
    @introduction.introduction_token = SecureRandom.urlsafe_base64

    if @introduction.save
      send_introduction_mail
      redirect_to mypage_path, notice: '招待メールを送信しました。'
    else
      render :new
    end
  end

  private

  def introduction_params
    params.fetch(:introduction, {}).permit(
      :introduced_email
    )
  end

  def send_introduction_mail
    IntroductionMailer.introduction_mail(@introduction).deliver_now
  end
end
