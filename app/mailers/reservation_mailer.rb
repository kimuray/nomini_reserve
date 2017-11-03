class ReservationMailer < ApplicationMailer
  default template_path: 'mailers/reservation_mailer'
  default from: Settings.mail.from

  def notice_reservation_to_nomini(reservation)
    @reservation = reservation
    mail(to: Settings.mail.to, subject: '予約申請が入りました')
  end

  def notice_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '予約申請を承りました')
  end

  def remand_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '予約がキャンセルされました')
  end

  def done_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '予約が承認されました')
  end

  def cancel_reservation_to_nomini(reservation)
    @reservation = reservation
    mail(to: Settings.mail.to, subject: '予約がキャンセルされました')
  end

  def cancel_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '予約をキャンセルしました')
  end

  def update_reservation_to_nomini(reservation)
    @reservation = reservation
    mail(to: Settings.mail.to, subject: '予約内容が変更されました')
  end

  def update_reservation_to_user(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: '予約内容を変更しました')
  end
end
