require 'logger'

class Batches::Base
  @@is_dryrun = false

  class << self
    def logger
      @@logger ||= Logger.new(
        dryrun? ? STDOUT : File.join(Rails.root, 'log', "#{Rails.env.underscore}.log")
      )
    end

    def dryrun(*args)
      @@is_dryrun = true
      logger.level = Logger::DEBUG
      exec(*args)
    end

    def dryrun?
      @@is_dryrun
    end
  end
end
