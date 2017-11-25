class Batches::PaymentConfirmBatch < Batches::Base
  def self.exec
    logger.info('start')
    logger.debug('show only in dryrun mode.')
    unless dryrun?
      send_confirm_price_mail
    end
    logger.info('finish.')
  end

  def self.send_confirm_price_mail
    Reservation.where(use_date: Date.yesterday).find_each do |reservation|
      ReservationMailer.confirm_use_price_to_shop(reservation).deliver_now
      logger.info("Send_confirm_price,#{reservation.use_date},#{reservation.id},#{reservation.shop.email},#{reservation.tax_included_price},#{reservation.people_count}")
    end
  end
end
