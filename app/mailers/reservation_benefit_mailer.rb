class ReservationBenefitMailer < ApplicationMailer
  default template_path: 'mailers/reservation_benefit_mailer'
  default from: Settings.mail.from

  def notice_add_point(reservation_benefit)
    @reservation_benefit = reservation_benefit
    mail(to: @reservation_benefit.user.email, subject: '【nomini】今回取得ポイントのお知らせ')
  end

  def notice_add_introduction_point(user, introduced_user)
    @user = user
    @introduced_user = introduced_user
    mail(to: @user.email, subject: '【nomini】紹介ポイント付与のお知らせ')
  end
end
