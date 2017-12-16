class Batches::ForcePaymentBatch < Batches::Base
  def self.exec
    logger.info('Force payment batch start.')
    logger.debug('show only in dryrun mode.')
    unless dryrun?
      force_payment
    end
    logger.info('Force payment batch finish.')
  end

  def self.force_payment
    ReservationPayment.requested.where(limited_on: Date.yesterday).find_each do |payment|
      customer_id = payment.user&.subscription&.customer_id
      payment.force_liquidation(customer_id)
      if payment.force_paid?
        PaymentMailer.force_paid(payment).deliver_now
      end
      logger.info("Force_payment,#{payment.user_id},#{payment.reservation_id},#{payment.tax_included_amount},#{payment.status}")
    end
  end
end
