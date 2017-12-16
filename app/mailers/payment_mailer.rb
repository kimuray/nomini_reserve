class PaymentMailer < ApplicationMailer
  default template_path: 'mailers/payment_mailer'
  default from: Settings.mail.from

  def notification(payment)
    @payment = payment
    mail(to: @payment.user.email, subject: "【nomini】ご利用ありがとうございました。お支払い手続きをお済ませ下さい。")
  end

  def force_paid(payment)
    @payment = payment
    mail(to: @payment.user.email, subject: "【nomini】ご利用後のお支払い状況のご確認をお願い致します。")
  end

  def payment_complete(payment)
    @payment = payment
    mail(to: @payment.user.email, subject: "【nomini】お支払いが完了しました。またのご利用をお待ちしております。")
  end
end
