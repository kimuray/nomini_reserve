class SystemSetting < ApplicationRecord
  validates :logical_name, presence: true
  validates :physical_name, presence: true
  validates :value, presence: true

  class << self
    def introduction_point
      find_by(physical_name: 'introduction').value
    end

    def exchange_line
      find_by(physical_name: 'exchange').value
    end
  end
end
