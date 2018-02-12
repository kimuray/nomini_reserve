class SystemSetting < ApplicationRecord
  validates :config_name, presence: true
  validates :value, presence: true

  class << self
    def introduction_point
      find_by(config_name: 'introduction').value
    end

    def exchange_line
      find_by(config_name: 'exchange').value
    end
  end
end
