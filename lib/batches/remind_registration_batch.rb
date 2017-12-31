class Batches::RemindRegistrationBatch < Batches::Base
  def self.exec
    logger.info('Remind registration batch start')
    logger.debug('show only in dryrun mode.')
    unless dryrun?
      User.where(confirmed_at: nil).find_each do |user|
        UserMailer.remind_confirmation(user).deliver_now
      end
    end
    logger.info('Remind registration batch finish.')
  end
end
