class ShopUsage < ApplicationRecord
  belongs_to :shop
  belongs_to :reservation_category
end
