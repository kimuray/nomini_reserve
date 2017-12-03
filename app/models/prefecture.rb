class Prefecture < ApplicationRecord
  has_many :cities
  DEFAULT = 13
end
