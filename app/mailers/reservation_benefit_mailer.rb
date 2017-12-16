class ReservationBenefitMailer < ApplicationMailer
  default template_path: 'mailers/reservation_benefit_mailer'
  default from: Settings.mail.from

  def notice_add_point(reservation_benefit)
    @reservation_benefit = reservation_benefit
    mail(to: @reservation_benefit.user.email, subject: '【nomini】今回取得ポイントのお知らせ')
  end
end
