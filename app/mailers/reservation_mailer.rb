class ReservationMailer < ApplicationMailer
  default template_path: 'mailers/reservation_mailer'
  default from: Settings.mail.from

  def notice_reservation_to_nomini(reservation)
    @reservation = reservation
    mail(to: Settings.mail.to, subject: '【nomini】予約申請が入りました')
  end

  def notice_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約申請を致しました')
  end

  def remand_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】ご予約をお受けする事が出来ませんでした。')
  end

  def done_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】ご予約を確定いたしました。')
  end

  def cancel_reservation_to_nomini(reservation)
    @reservation = reservation
    mail(to: Settings.mail.to, subject: '【nomini】利用者より予約キャンセルの申請がありました。')
  end

  def cancel_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約キャンセルの申請しました。')
  end

  def update_reservation_to_nomini(reservation)
    @reservation = reservation
    mail(to: Settings.mail.to, subject: '【nomini】利用者より予約内容変更申請が入りました。')
  end

  def update_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約内容変更申請を行いまいした。')
  end

  def notice_reservation_to_nomini_from_shop(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約が確定しました。')
  end

  def notice_reservation_to_user_from_shop(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約が確定しました。')
  end

  def update_reservation_to_nomini_from_shop(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約変更（人数・時間）を受け付けました。')
  end

  def update_reservation_to_user_from_shop(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約変更（人数・時間）を受け付けました。')
  end

  def cancel_reservation_to_nomini_from_shop(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約キャンセルが確定しました。')
  end

  def cancel_reservation_to_user_from_shop(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '【nomini】予約キャンセルが確定しました。')
  end

  def confirm_use_price_to_shop(reservation)
    @reservation = reservation
    mail(to: @reservation.shop.email, subject: '【nomini】ご利用内容のご確認をお願い致します。')
  end
end
