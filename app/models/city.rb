class City < ApplicationRecord
  belongs_to :prefecture
  has_many :shops
  DEFAULT = '13101'

  def self.initial_display
    find_by(city_code: DEFAULT)
  end

  def same_prefecture_cities
    prefecture.cities
  end
end
