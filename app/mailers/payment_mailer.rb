class PaymentMailer < ApplicationMailer
  default template_path: 'mailers/payment_mailer'
  default from: Settings.mail.from

  def notification(payment)
    @payment = payment
    mail(to: @payment.user.email, subject: "【nomini】#{@payment.reservation.shop.name}ご利用の決済について")
  end
end
